<template>
    <Editor
        :api-key="tinymceAPIKey"
        :init="editorConfig"
        v-model="editorData"
      />
</template>
<script setup lang="ts">
import { ref } from "vue";
import Editor from "@tinymce/tinymce-vue";

let fileMap: any = {};
const tinymceAPIKey = ref("2tav4z4ylsvkb7he838uc03pgua9bu5c2evy4ursqkybua7h");
const useDarkMode = window.matchMedia("(prefers-color-scheme: dark)").matches;
const isSmallScreen = window.matchMedia("(max-width: 1023.5px)").matches;
const editorConfig = ref({
  language: "zh_CN",
  selector: "textarea#open-source-plugins",
  plugins: [
    "preview",
    "importcss",
    "searchreplace",
    "autolink",
    "autosave",
    "save",
    "directionality",
    "code",
    "visualblocks",
    "visualchars",
    "fullscreen",
    "image",
    "link",
    "media",
    "codesample",
    "table",
    "charmap",
    "pagebreak",
    "nonbreaking",
    "anchor",
    "insertdatetime",
    "advlist",
    "lists",
    "wordcount",
    "help",
    "charmap",
    "quickbars",
    "emoticons",
  ],
  editimage_cors_hosts: ["picsum.photos"],
  menubar: "file edit view insert format tools table help",
  toolbar:
    " undo redo | save bold italic underline strikethrough | fontfamily fontsize blocks | alignleft aligncenter alignright alignjustify | outdent indent |  numlist bullist | forecolor backcolor removeformat | pagebreak | charmap emoticons | fullscreen  preview print | insertfile image media template link anchor codesample | ltr rtl",
  toolbar_sticky: true,
  toolbar_sticky_offset: isSmallScreen ? 102 : 108,
  autosave_ask_before_unload: true,
  autosave_interval: "30s",
  autosave_prefix: "{path}{query}-{id}-",
  autosave_restore_when_empty: false,
  autosave_retention: "2m",
  save_enablewhendirty: false,
  save_onsavecallback: () => {
    console.log("Saved");
    showEditorData();
  },
  save_oncancelcallback: () => {
    console.log("Save canceled");
  },
  image_advtab: true,
  // link_list: [
  //   { title: "My page 1", value: "https://www.tiny.cloud" },
  //   { title: "My page 2", value: "http://www.moxiecode.com" },
  // ],
  // image_list: [
  //   { title: "My page 1", value: "https://www.tiny.cloud" },
  //   { title: "My page 2", value: "http://www.moxiecode.com" },
  // ],
  // image_class_list: [
  //   { title: "None", value: "" },
  //   { title: "Some class", value: "class-name" },
  // ],
  importcss_append: true,
  file_picker_callback: (
    callback: (
      arg0: string,
      arg1: { text?: string; alt?: string; source2?: string; poster?: string }
    ) => void,
    value: any,
    meta: { filetype: string }
  ) => {
    /* Provide file and text for the link dialog */
    if (meta.filetype === "file") {
      callback("", { text: "" });
    }

    /* Provide image and alt text for the image dialog */
    const inputfile = document.createElement("input");
    inputfile.className = "inputFiles";
    inputfile.type = "file";
    inputfile.accept = "image/*";

    if (meta.filetype === "media") {
      inputfile.accept = "video/*,audio/*";
    }
    inputfile.onchange = async function () {
      const files = inputfile.files;
      if (files) {
        const file = files[0];
        const arrayBuffer = await file.arrayBuffer();
        const blob = new Blob([arrayBuffer], {
          type: file.type,
        });
        callback(URL.createObjectURL(blob), { alt: "" });
      }
      const inputFs = document.getElementsByClassName("inputFiles");
      for (const fi in inputFs) {
        if (Object.prototype.hasOwnProperty.call(inputFs, fi)) {
          const element = inputFs[fi];
          element.remove();
        }
      }
      inputfile.remove();
    };
    inputfile.click();

    /* Provide alternative source and posted for the media dialog */
  },
  // templates: [
  //   {
  //     title: "New Table",
  //     description: "creates a new table",
  //     content:
  //       '<div class="mceTmpl"><table width="98%%"  border="0" cellspacing="0" cellpadding="0"><tr><th scope="col"> </th><th scope="col"> </th></tr><tr><td> </td><td> </td></tr></table></div>',
  //   },
  //   {
  //     title: "Starting my story",
  //     description: "A cure for writers block",
  //     content: "Once upon a time...",
  //   },
  //   {
  //     title: "New list with dates",
  //     description: "New List with dates",
  //     content:
  //       '<div class="mceTmpl"><span class="cdate">cdate</span><br><span class="mdate">mdate</span><h2>My List</h2><ul><li></li><li></li></ul></div>',
  //   },
  // ],
  // template_cdate_format: "[Date Created (CDATE): %Y/%m/%d : %H:%M:%S]",
  // template_mdate_format: "[Date Modified (MDATE): %Y/%m/%d : %H:%M:%S]",
  height: 600,
  image_caption: true,
  quickbars_selection_toolbar:
    "bold italic | quicklink h2 h3 blockquote quickimage quicktable",
  noneditable_class: "mceNonEditable",
  toolbar_mode: "sliding",
  contextmenu: "link image table",
  skin: useDarkMode ? "oxide-dark" : "oxide", //"snow",
  icons: "thin",
  content_css: useDarkMode ? "dark" : "default",
  content_style:
    "body { font-family:Helvetica,Arial,sans-serif; font-size:16px }",
});
const editorData = ref(
  '<table><tbody><tr><th colspan="1" rowspan="1"><p></p></th><th colspan="1" rowspan="1"><p></p></th><th colspan="1" rowspan="1"><p></p></th></tr><tr><td colspan="1" rowspan="1" style="background-color: null"><p></p></td><td colspan="1" rowspan="1" style="background-color: null"><p>dsa</p></td><td colspan="1" rowspan="1" style="background-color: null"><p>das</p></td></tr><tr><td colspan="1" rowspan="1" style="background-color: null"><p></p></td><td colspan="1" rowspan="1" style="background-color: null"><p>asf</p></td></tr></tbody></table><p>Example Text 2</p><p>Or add completely custom input rules. We added a custom extension here that replaces smilies like <code>:-D</code>, <code><3</code> or <code>>:P</code> with emojis. Try it out:</p><p></p><p>You can also teach the editor new things. For example to recognize hex colors and add a color swatch on the fly: #FFF, #0D0D0D, #616161, #A975FF, #FB5151, #FD9170, #FFCB6B, #68CEF8, #80cbc4, #9DEF8F</p>'
);
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
</script>