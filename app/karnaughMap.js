// karnaughMap.js - カルノー図の表示
//
// Author: KITAJIMA Akira <kitajima@osakac.ac.jp>
// Copyright 2025 KITAJIMA Akira

/**
 * グレイコードにエンコードする。
 * @param {int} value 元の値
 * @returns エンコードされた値
 */
function encodeToGrayCode(value) {
    return value ^ (value >> 1);
}

/**
 * 2のべき乗を求める。
 * @param {*} v  べき乗の指数
 * @returns 2のべき乗
 */
function pow2(v) {
    return (v < 1) ? 1 : 2 << (v - 1);
}

/**
 * ビット列の文字列に変換する。
 * @param {int} value 値
 * @param {int} scale スケール
 * @returns ビット列の文字列
 */
function toBinaryString(value, scale) {
    return value.toString(2).padStart(scale, '0');
} 

class karnaughMap {
    scale;
    truthTable;
    cssFileName;

    constructor(cssName) {
        this.cssFileName = cssName;
    }

    parseLine(line) {
        return line && line.split(/\s+/).filter(s => s.length > 0);
    }

    /**
     * 入力テキストを解析する。
     * @param {ArrayIterator} lines 入力テキスト
     * @returns {int} カルノー図の個数
     */
    parse(lines) {
        // 最初のデータに合わせて初期設定する。
        let line = lines.next();
        let [vIn, vOut] = this.parseLine(line.value);
        if (vOut === undefined)
            throw '入力テキストのフォーマットが間違っています。';
        this.scale = vIn.length;

        const numElements = pow2(this.scale);
        this.truthTable = new Array(numElements);

        const size = vOut.length;

        // 1要素ずつデータを読み込みtruthTableに格納する。
        do {
            this.truthTable[parseInt(vIn, 2)] = vOut;
            line = lines.next();
        } while (!line.done && ([vIn, vOut] = this.parseLine(line.value)) && vOut !== undefined);

        return size;
    }

    makeTable(index) {
        const colScale = this.scale / 2 + this.scale % 2;  // 横の桁数
        const rowScale = this.scale / 2;  // 縦の桁数
        const colSize = pow2(colScale);  // 横のセル数
        const rowSize = pow2(rowScale);  // 縦のセル数

        // テーブル要素を作成する。
        const table = document.createElement('table');
        table.appendChild(document.createElement('caption')).textContent = `#${index + 1}`;

		// 見出し(横)
		// 2段にして斜め線を入れる。 (CSSのemptyを利用するため、斜め線の箇所をemptyにする。)
        const thead = table.appendChild(document.createElement('thead'));
        
        // 1段目
        const tr = thead.appendChild(document.createElement('tr'));
        tr.appendChild(document.createElement('th')).textContent = '';  // 斜め線
        tr.appendChild(document.createElement('th')).textContent = 'AB';
        for (let col = 0; col < colSize; col++) {
            tr.appendChild(document.createElement('th')).textContent = toBinaryString(encodeToGrayCode(col), colScale);
        }

        // 2段目
        const tr2 = thead.appendChild(document.createElement('tr'));
        tr2.appendChild(document.createElement('th')).textContent = 'CD';
        tr2.appendChild(document.createElement('th')).textContent = '';  // 斜め線
        for (let col = 0; col < colSize; col++) {
            tr2.appendChild(document.createElement('th')).textContent = ' ';  // 空白を入れてemptyではなくしている。
        }

        // 表本体
        const tbody = table.appendChild(document.createElement('tbody'));
        for (let row = 0; row < rowSize; row++) {
            const tr = tbody.appendChild(document.createElement('tr'));
            // 見出し(縦)
            tr.appendChild(document.createElement('th')).textContent = toBinaryString(encodeToGrayCode(row), rowScale);
            tr.appendChild(document.createElement('th')).textContent = ' ';
            // 数値
            for (let col = 0; col < colSize; col++) {
                const i = (encodeToGrayCode(col) << 2) + encodeToGrayCode(row);
                const bit = this.truthTable[i][index] === '1';
                tr.appendChild(document.createElement('td')).textContent = bit ? '1' : ' ';
            }
        }

        return table;
    }
}

// ------------------------------------------------------------
// メイン処理

const km = new karnaughMap('karnaughmap.css');

/**
 * シミュレーション結果をもとにエミュレータを初期設定する。
 * @param {string} text シミュレーション結果の文字列(全体) 
 */
function handleInput(text) {
    try {
        const tables = [];
        const lines = text.split(/[\n\r]+/);
        const size = km.parse(lines.values());
        document.body.innerHTML = '';
        for (let i = 0; i < size; i++) {
            tables.push(km.makeTable(i));
            document.body.appendChild(tables[i]);
        }
        

    } catch (error) {
        alert(error);
    }
}

// ------------------------------------------------------------
// イベントハンドラ

document.addEventListener('drop', event => inputByDrop(event, handleInput), false);
