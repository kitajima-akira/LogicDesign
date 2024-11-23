// disp7seg.js - 7セグメントLEDエミュレータ
//
// Author: KITAJIMA Akira <kitajima@osakac.ac.jp>
// Copyright 2024 KITAJIMA Akira
//
// snap.svg-min.js (Snap.svg)使用

// //////////////////
// 表示に使用する記号

// 一時停止
const pauseSymbol = `
<svg width="17" height="14" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <rect x="0" y="0" width="4" height="14" stroke="white" fill="white" stroke-width="1"/>
    <rect x="8" y="0" width="4" height="14" stroke="white" fill="white" stroke-width="1"/>
</svg>`;

// 再開
const playSymbol = `
<svg width="12" height="14" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <polygon points="0, 0  0, 14  11, 7" stroke="white" fill="white" stroke-width="0"/>
</svg>`;

// 次
const nextSymbol = `
<svg width="24" height="14" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <polygon points="0, 0  0, 14  11, 7" stroke="white" fill="white" stroke-width="0"/>
    <polygon points="12, 0  12, 14  23, 7" stroke="white" fill="white" stroke-width="0"/>
</svg>`;

// 前
const backSymbol = `
<svg width="24" height="14" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <polygon points="11, 0  11, 14  0, 7" stroke="white" fill="white" stroke-width="0"/>
    <polygon points="23, 0  23, 14  12, 7" stroke="white" fill="white" stroke-width="0"/>
</svg>`;

/** 7セグメントLED */
class SevenSegmentDisplay {
    id;  // DOMのID
    svg;  // DOMのSVGオブジェクト

    //       --Y(6)--
    //      /        /
    //    Y(1)      Y(5)
    //     /        /
    //     /--Y(0)--/ 
    //     /        /
    //   Y(2)     Y(4)   
    //    /        /
    //     --Y(3)--
    // 各セグメントと出力ビット列の各ビットとの対応
    segmentMap = {
        segment0: 6,
        segment1: 5,
        segment2: 4,
        segment3: 3,
        segment4: 2,
        segment5: 1,
        segment6: 0
    }

    colorLEDoff = 'rgb(146, 146, 126)';  // OFFのときのLEDの色
    colorLEDon = 'rgb(255, 51, 51)';  // ONのときのLEDの色
    colorBackground = 'rgb(90, 90, 90)';  // 背景色

    /**
     * コンストラクタ
     * @param {string} id DOM上の7セグメントLEDを表すSVGのId 
     * 既定のSVG形式7セグメントLEDがDOM上にあることを想定している。
     */
    constructor(id) {
        this.id = id;
        this.svg = Snap(document.getElementById(id));
        this.svg.node.style = `background-color: ${this.colorBackground};`;
    }

    /**
     * ビットパターンに応じて表示を更新する。
     * @param {string} pattern ビットパターン
     */
    update(pattern) {
        const segments = this.svg.selectAll('polygon');
        segments.forEach(segment => {
            for (let i = 0; i < 7; i++) {
                const segmentName = 'segment' + i;
                if (segment.node.className.baseVal.split(' ').includes(segmentName)) {
                    const fillColor = pattern.charAt(this.segmentMap[segmentName]) === '1'
                        ? this.colorLEDon : this.colorLEDoff;
                    segment.attr('fill', fillColor);
                }
            }
        });        
    }
}

/** 7セグメントLEDの並び */
class SSDArray {
    ssdArray;

    /**
     * コンストラクタ
     * @param {number} n 7セグメントLEDの個数 
     * @param {string} prefix 各7セグメントLEDのDOM上のIDのプレフィックス
     * @param {string} id 7セグメントLEDを表示する位置を表すDOM上の領域のID
     */
    constructor(n, prefix, id) {
        const ssdArea = document.getElementById(id);
        ssdArea.innerHTML = '';
        for (let i = 0; i < n; i++) {
            ssdArea.innerHTML += `<svg version="1.1"
    width="100" height="150"
    class="ssd"
    id="${prefix + i}"
    xmlns="http://www.w3.org/2000/svg">

    <polygon class="segment1" points="26.5, 17  24.5, 19.5  15, 69  20.5, 74.5  28, 68.5  35.5, 27" stroke="black" stroke-opacity="20%" />
    <polygon class="segment2" points="20, 77  13, 83.5  4.5, 130  6, 135  17.5, 126.5  25, 83" stroke="black" stroke-opacity="20%" />
    <polygon class="segment6" points="31.5, 13.5  28, 15.5  37, 25.5  82.5, 25.5  94, 16.5  90, 14" stroke="black" stroke-opacity="20%" />
    <polygon class="segment0" points="29, 70  21.5, 76  27, 82.5  73, 82.5  80, 76.5  75, 70" stroke="black" stroke-opacity="20%" />
    <polygon class="segment3" points="19.5, 127.5  7.5, 137  11.5, 139.5  68.5, 139.5  73, 137.5  64, 127.5" stroke="black" stroke-opacity="20%" />
    <polygon class="segment5" points="95.5, 17.5  84, 27  76.5, 69  81.5, 75.5  88.5, 69.5 97, 23.5" stroke="black" stroke-opacity="20%" />
    <polygon class="segment4" points="81, 78  74, 84  66, 126.5  74.5, 136  76.5, 134.5  85.5, 84" stroke="black" stroke-opacity="20%" />
    <circle class="segment7" fill="rgb(146, 146, 126)" cx="89" cy="134" r="6" stroke="black" stroke-opacity="20%" />
</svg>`;
        }
        this.ssdArray = [];
        for (let i = 0; i < n; i++) {
            const ssd = new SevenSegmentDisplay(prefix + i);
            this.ssdArray.push(ssd);
        }
    }

    /**
     * 表示内容を更新する。
     * @param {string[]} values 各7セグメントLEDに表示するパターンの並び 
     */
    update(values) {
        this.ssdArray.forEach((ssd, i) => {
            ssd.update(values[i]);
        });
    }
}

/** エミュレータ */
class Emulator {
    simulationData;  // シミュレーション結果の時系列データ
    currentTime;  // 現在時刻 (時系列の何番目か)
    ssdArray;  // 7セグメントLEDの並び
    inputDisplayArea;  // 入力表示部分のDOM要素
    formatInput;  // 入力表示部分を整形するための関数
    autoProgress;  // 自動進行中かどうか

    /**
     * コンストラクタ
     * @param {string} inputDisplayAreaId 入力表示部分のDOM要素のID
     * @param {*} formatInput 入力表示部分を整形するための関数
     * @param {string} displayAreaId 7セグメントLEDの並びを配置するためのDOM要素のID
     * @param {string} prefix 7セグメントLEDのIDのプレフィックス
     * @param {*} data シミュレーション結果の時系列データ
     */
    constructor(inputDisplayAreaId, formatInput, displayAreaId, prefix, data) {
        this.simulationData = data;
        this.currentTime = 0;
        this.inputDisplayArea = document.getElementById(inputDisplayAreaId);
        this.formatInput = formatInput; 
        this.autoProgress = false;
        this.ssdArray = new SSDArray(data[0].values.length, prefix, displayAreaId);
        this.updateDisplay();
    }

    /**
     * 表示を更新する。
     */
    updateDisplay() {
        const data = this.simulationData[this.currentTime];
        if (data === undefined)
            return;
        this.ssdArray.update(data.values);
        this.inputDisplayArea.innerHTML = `<p>#${this.currentTime}</p>` + this.formatInput(data.input);
    }

    /**
     * シミュレーション結果を一つ進める。
     */
    moveForward() {
        const dataLength = this.simulationData.length;
        if (dataLength <= 0)
            return;
        this.currentTime = (this.currentTime + 1) % dataLength;
        this.updateDisplay();
    }
    
    /**
     * シミュレーション結果を一つ戻す。
     */
    moveBackward() {
        const dataLength = this.simulationData.length;
        if (dataLength <= 0)
            return;
        this.currentTime = (dataLength + this.currentTime - 1) % dataLength;
        this.updateDisplay();     
    }

    /**
     * 表示の自動進行/手動進行を切り替える。
     */
    toggleAuto() {
        return this.autoProgress = !this.autoProgress;
    }
}

let emulator;  // エミュレータオブジェクト

/**
 * 2の補数から符号付き10進表現の数を得る。
 * @param {string} binaryText ビット列 
 * @returns 符号付き10進表現の値
 */
function getTwosComplement(binaryText) {
    if (binaryText[0] === '0' || binaryText.length === 1)  // 正の数または1ビット
        return parseInt(binaryText, 2);

    // 以下、負の数の場合

    // 符号ビットを除き、01反転する。
    let bitReverse = '';
    for (let c of binaryText.slice(1))
        bitReverse += c === '0' ? '1' : '0';

    // 10進表現に変換する。
    return - (parseInt(bitReverse, 2) + 1);
}

/**
 * 入力ビットパターンをHTMLで整形する。
 * @param {string} inputText 入力ビットパターン 
 * @returns HTMLで整形された入力
 */
function formatInput(inputText) {
    // 各表現に変換する。
    const values = inputText.split(/\s+/).filter(v => v.length > 0);
    const decimalValues = values.map(value => parseInt(value, 2));
    const twosComplementValues = values.map(value => getTwosComplement(value));
    const hexValues = decimalValues.map(value => value.toString(16).toUpperCase());

    // 表を作る。
    const rows = [
            {index: "2進表現", data: values},
            {index: "16進表現", data: hexValues}, 
            {index: "10進表現", data: decimalValues}, 
            {index: "2の補数", data: twosComplementValues} 
        ].reduce((s, r) => `${s}<tr><th>${r.index}</th>${
                r.data.reduce((s, value, i) => `${s}<td class="${i % 2 ? 'even-column' : 'odd-column'}">${value}</td>`, '')
            }</tr>`, 
            '');

    return `<table id="input-values">
    <caption>入力値</caption>
    <tbody>${rows}</tbody>
</table>`;
}

/**
 * 入力ファイルの文字列を解析する。
 * @param {string} inputText 入力ファイルの文字列(全体)
 * @returns シミュレーション結果データ
 */
function parseInput(inputText) {
    const lines = inputText.split(/[\n\r]+/);
    return lines.reduce((list, line) => {
        if (line.length <= 0)
            return list;
        const [input, outputs] = line.split(/\s*:\s*/);
        if (outputs === undefined)
            throw '入力ファイルのフォーマットが間違っています。';
        let values = outputs.split(/\s+/).filter(s => s.length > 0);
        if (values !== undefined && values.length > 0) {
            values = values.filter(value => value.length === 7);
            list.push({input, values});
        }
        return list;
    }, []);
}

/**
 * シミュレーション結果をもとにエミュレータを初期設定する。
 * @param {string} text シミュレーション結果の文字列(全体) 
 */
function initialize(text) {
    try {
        const simulationData = parseInput(text);
        emulator = new Emulator('input-display-area', formatInput, 'display-area', 'ssd', simulationData);
        toggleAuto();
        document.getElementById('button-area').hidden = false;
    } catch (error) {
        alert(error);
    }
}

// ------------------------------------------------------------
// イベントハンドラ

document.getElementById('button-area').hidden = true;

// //////////////////////////
// 戻るボタン (一つ前に戻す。)

const navigationLeft = document.getElementById('navigation#prev');
navigationLeft.addEventListener('click', event => emulator.moveBackward());
navigationLeft.innerHTML = backSymbol + '前の値';

// /////////////////////////
// 進むボタン (次に進める。)

const navigationRight = document.getElementById('navigation#next');
navigationRight.addEventListener('click', event => emulator.moveForward());
navigationRight.innerHTML = nextSymbol + '次の値';

// /////////////////////////
// autoボタン (自動・手動の切り替え。)

/**
 * autoボタンを押したときの処理を行う。
 * @param {*} event イベント
 */
function toggleAuto(event) {
    navigationAuto.innerHTML 
        = emulator !== undefined && !emulator.toggleAuto() 
            ? playSymbol + '再開' : pauseSymbol + '停止';
}

const navigationAuto = document.getElementById('navigation#auto');
navigationAuto.addEventListener('click', toggleAuto);
toggleAuto();

// //////////////////////////////////
// ファイルドロップ (データを読み込む。)

/**
 * ドロップされたときの処理を行う。
 * @param {*} event イベント
 */
function handleFiles(event) {
	if (event !== undefined && event.dataTransfer !== undefined) {
		event.stopPropagation();
		event.preventDefault();

        // テキストをドロップした場合
		const text = event.dataTransfer.getData('text/plain');
		if (text !== '') {
            // ドロップされたテキストで初期化する。
            initialize(text);
			return;
		}

        // ファイルをドロップした場合
        const file = event.dataTransfer.files[0];
        if (file !== undefined) {
            // ドロップされたファイルを読み込む。
            const reader = new FileReader();
            reader.addEventListener('load', event => initialize(reader.result));
            reader.readAsText(file);
        }
    }
}

// ドラッグ&ドロップ
// https://web.dev/articles/read-files

/**
 * ドロップ操作を行えるようドラッグオーバー時に対応する。
 * @param {*} event イベント
 */
function handleDragOver(event) {
	event.stopPropagation();
	event.preventDefault();
	event.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
}

// Setup the dnd listeners.
document.addEventListener('dragover', handleDragOver, false);
document.addEventListener('drop', handleFiles, false);

// ////////////////////////
// タイマー (自動更新する。)

/**
 * 一定時間経過したときの処理を行う。
 */
function refreshDisplay() {
    if (emulator === undefined || !emulator.autoProgress)
        return;
    emulator.moveForward();
}

setInterval(refreshDisplay, 1000);
