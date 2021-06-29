// global.d.ts:
declare var sItemData: string[];
declare var sTemplate: string;

// 使用.ts:
globalThis.sTemplate = 'data.responseText';
globalThis.sItemData = [];