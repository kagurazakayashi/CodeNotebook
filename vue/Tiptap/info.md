## 文档
[Tiptap](https://tiptap.dev/introduction)

## 使用
- vue
```
<Editor v-model="editorData" />
<v-btn variant="outlined" @click="showEditorData()"> Editor </v-btn>
```
- script
```<script setup lang="ts">
import { ref } from "vue";
import Editor from "@/components/editor.vue";

let fileMap: any = {};

async function showEditorData() {
  fileMap = {};
  const val = editorData.value;
  const parser = new DOMParser();
  const doc = parser.parseFromString(val, "text/html");
  const imgs = doc.getElementsByTagName("img");
  await handleElements(imgs);
  const videos = doc.getElementsByTagName("video");
  await handleElements(videos);
  const audios = doc.getElementsByTagName("audio");
  await handleElements(audios);
  const sources = doc.getElementsByTagName("source");
  await handleElements(sources);

  const serializer = new XMLSerializer();
  const str = serializer.serializeToString(doc);
  console.log(str);
  console.log(fileMap);
}
async function handleElements(
  elements:
    | HTMLCollectionOf<HTMLImageElement>
    | HTMLCollectionOf<HTMLVideoElement>
    | HTMLCollectionOf<HTMLAudioElement>
    | HTMLCollectionOf<HTMLSourceElement>
) {
  for (const Ii in elements) {
    if (Object.prototype.hasOwnProperty.call(elements, Ii)) {
      const element = elements[Ii];
      const keys = Object.keys(fileMap);
      if (element instanceof HTMLVideoElement) {
        if (element.poster.startsWith("data:")) {
          const fmLen = baseToExt(element.poster, keys);
          fileMap[fmLen] = element.poster;
          element.poster = fmLen.toString();
          continue;
        }
        const response = await fetch(element.poster);
        const blob = await response.blob();
        const base64 = await blobToBase64(blob);
        const fmLen = baseToExt(base64, keys);
        fileMap[fmLen] = base64;
        element.poster = fmLen.toString();
        continue;
      }
      if (element.src.startsWith("data:")) {
        const fmLen = baseToExt(element.src, keys);
        fileMap[fmLen] = element.src;
        element.src = fmLen.toString();
        continue;
      }
      const response = await fetch(element.src);
      const blob = await response.blob();
      const base64 = await blobToBase64(blob);
      const fmLen = baseToExt(base64, keys);
      fileMap[fmLen] = base64;
      element.src = fmLen.toString();
    }
  }
}
function baseToExt(base64: string, keys: string[]): string {
  const tempL = base64.split(";");
  let ext = "";
  if (tempL.length > 1) {
    const tempL2 = tempL[0].split("/");
    if (tempL2.length > 1) {
      ext = tempL2[1];
    }
  }
  return keys.length + "." + ext;
}

async function blobToBase64(blob: Blob): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => {
      const base64 = reader.result as string;
      resolve(base64);
    };
    reader.onerror = reject;
    reader.readAsDataURL(blob);
  });
}
const editorData = ref(
  '<table><tbody><tr><th colspan="1" rowspan="1"><p></p></th><th colspan="1" rowspan="1"><p></p></th><th colspan="1" rowspan="1"><p></p></th></tr><tr><td colspan="1" rowspan="1" style="background-color: null"><p></p></td><td colspan="1" rowspan="1" style="background-color: null"><p>dsa</p></td><td colspan="1" rowspan="1" style="background-color: null"><p>das</p></td></tr><tr><td colspan="1" rowspan="1" style="background-color: null"><p></p></td><td colspan="1" rowspan="1" style="background-color: null"><p>asf</p></td></tr></tbody></table><p>Example Text 2</p><p>Or add completely custom input rules. We added a custom extension here that replaces smilies like <code>:-D</code>, <code><3</code> or <code>>:P</code> with emojis. Try it out:</p><p></p><p>You can also teach the editor new things. For example to recognize hex colors and add a color swatch on the fly: #FFF, #0D0D0D, #616161, #A975FF, #FB5151, #FD9170, #FFCB6B, #68CEF8, #80cbc4, #9DEF8F</p>'
);
</script>
```