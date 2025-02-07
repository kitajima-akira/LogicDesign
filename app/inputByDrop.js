// inputByDrop.js - ドロップされたデータを処理するための関数の提供
//
// Author: KITAJIMA Akira <kitajima@osakac.ac.jp>
// Copyright 2025 KITAJIMA Akira

// 使用例
// document.addEventListener('drop', event => inputByDrop(event, handleInput), false);

/**
 * ドロップされたデータを用いて処理を行う。
 * @param {*} event イベント
 * @param {*} handle 処理を行う関数 (引数はドロップされたデータ)
 */
function inputByDrop(event, handle) {
	if (event !== undefined && event.dataTransfer !== undefined) {
		event.stopPropagation();
		event.preventDefault();

        // テキストをドロップした場合
		const text = event.dataTransfer.getData('text/plain');
		if (text !== '') {
            // ドロップされたテキストで処理を行う。
            handle(text);
			return;
		}

        // ファイルをドロップした場合
        const file = event.dataTransfer.files[0];
        if (file !== undefined) {
            // ドロップされたファイルを読み込む。
            const reader = new FileReader();
            reader.addEventListener('load', event => handle(reader.result));
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
