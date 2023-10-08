<template>
  <div class="editorView">
    <div class="toolbar">
      <!-- 粗体 -->
      <button
        @click="editor.chain().focus().toggleBold().run()"
        :disabled="!editor.can().chain().focus().toggleBold().run()"
        :class="{ 'is-active': editor.isActive('bold') }"
      >
        <v-icon icon="mdi-format-bold"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.bold") }}
        </v-tooltip>
      </button>
      <!-- 斜体 -->
      <button
        @click="editor.chain().focus().toggleItalic().run()"
        :disabled="!editor.can().chain().focus().toggleItalic().run()"
        :class="{ 'is-active': editor.isActive('italic') }"
      >
        <v-icon icon="mdi-format-italic"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.italic") }}
        </v-tooltip>
      </button>
      <!-- 下划线 -->
      <button
        @click="editor.chain().focus().toggleUnderline().run()"
        :disabled="!editor.can().chain().focus().toggleUnderline().run()"
        :class="{ 'is-active': editor.isActive('underline') }"
      >
        <v-icon icon="mdi-format-underline"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.underline") }}
        </v-tooltip>
      </button>
      <!-- 删除线 -->
      <button
        @click="editor.chain().focus().toggleStrike().run()"
        :disabled="!editor.can().chain().focus().toggleStrike().run()"
        :class="{ 'is-active': editor.isActive('strike') }"
      >
        <v-icon icon="mdi-format-strikethrough"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.strikethrough") }}
        </v-tooltip>
      </button>
      <div class="toolDivider"></div>
      <!-- 正文 -->
      <button
        @click="editor.chain().focus().setParagraph().run()"
        :class="{ 'is-active': editor.isActive('paragraph') }"
      >
        <v-icon icon="mdi-format-paragraph"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.text") }}
        </v-tooltip>
      </button>
      <!-- 标题 -->
      <button
        @click="editor.chain().focus().toggleHeading({ level: 1 }).run()"
        :class="{ 'is-active': editor.isActive('heading', { level: 1 }) }"
      >
        <v-icon icon="mdi-format-header-1"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.h1") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().toggleHeading({ level: 2 }).run()"
        :class="{ 'is-active': editor.isActive('heading', { level: 2 }) }"
      >
        <v-icon icon="mdi-format-header-2"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.h2") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().toggleHeading({ level: 3 }).run()"
        :class="{ 'is-active': editor.isActive('heading', { level: 3 }) }"
      >
        <v-icon icon="mdi-format-header-3"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.h3") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().toggleHeading({ level: 4 }).run()"
        :class="{ 'is-active': editor.isActive('heading', { level: 4 }) }"
      >
        <v-icon icon="mdi-format-header-4"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.h4") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().toggleHeading({ level: 5 }).run()"
        :class="{ 'is-active': editor.isActive('heading', { level: 5 }) }"
      >
        <v-icon icon="mdi-format-header-5"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.h5") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().toggleHeading({ level: 6 }).run()"
        :class="{ 'is-active': editor.isActive('heading', { level: 6 }) }"
      >
        <v-icon icon="mdi-format-header-6"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.h6") }}
        </v-tooltip>
      </button>
      <!-- 字体颜色 -->
      <span class="combination">
        <button
          @click="editor.chain().focus().setColor(textColor).run()"
          :class="{ 'is-active': editor.isActive('blockquote') }"
        >
          <v-icon icon="mdi-format-color-text"></v-icon>
          <v-tooltip activator="parent" location="top">
            {{ $t("editor.tooltip.blockquote") }}
          </v-tooltip>
          <span
            class="colorindicator"
            :style="{ 'background-color': textColor }"
          ></span>
        </button>
        <button class="selectColor" @click="pickerColor = textColor">
          <v-icon icon="mdi-menu-down"></v-icon>
          <v-tooltip activator="parent" location="top">
            {{ $t("editor.tooltip.selectColor") }}
          </v-tooltip>
          <v-overlay
            v-model="textColorDialog"
            activator="parent"
            location-strategy="connected"
            scroll-strategy="reposition"
          >
            <div class="colorDialog">
              <v-color-picker v-model="pickerColor" hide-inputs show-swatches>
              </v-color-picker>

              <v-row no-gutters>
                <v-col cols="12" sm="6" />
                <v-col cols="12" sm="6">
                  <v-btn
                    class="confirm"
                    variant="outlined"
                    @click="setTextColor"
                  >
                    {{ $t("button.confirm") }}
                  </v-btn>
                </v-col>
              </v-row>
            </div>
          </v-overlay>
        </button>
      </span>
      <!-- <input type="color" /> -->
      <!-- 高亮 -->
      <span class="combination">
        <button
          @click="
            editor
              .chain()
              .focus()
              .toggleHighlight({ color: heightlightColor })
              .run()
          "
          :class="{
            'is-active': editor.isActive('highlight', {
              color: heightlightColor,
            }),
          }"
        >
          <v-icon icon="mdi-format-color-highlight"></v-icon>
          <v-tooltip activator="parent" location="top">
            {{ $t("editor.tooltip.highlight") }}
          </v-tooltip>
          <span
            class="colorindicator"
            :style="{ 'background-color': heightlightColor }"
          ></span>
        </button>
        <button class="selectColor" @click="pickerColor = heightlightColor">
          <v-icon icon="mdi-menu-down"></v-icon>
          <v-tooltip activator="parent" location="top">
            {{ $t("editor.tooltip.selectColor") }}
          </v-tooltip>
          <v-overlay
            v-model="heightlightColorDialog"
            activator="parent"
            location-strategy="connected"
            scroll-strategy="reposition"
          >
            <div class="colorDialog">
              <v-color-picker v-model="pickerColor" hide-inputs show-swatches>
              </v-color-picker>

              <v-row no-gutters>
                <v-col cols="12" sm="6" />
                <v-col cols="12" sm="6">
                  <v-btn
                    class="confirm"
                    variant="outlined"
                    @click="setheightlightColor"
                  >
                    {{ $t("button.confirm") }}
                  </v-btn>
                </v-col>
              </v-row>
            </div>
          </v-overlay>
        </button>
      </span>
      <div class="toolDivider"></div>
      <!-- 对齐 -->
      <button
        @click="editor.chain().focus().setTextAlign('left').run()"
        :class="{ 'is-active': editor.isActive({ textAlign: 'left' }) }"
      >
        <v-icon icon="mdi-format-align-left"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.align.left") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().setTextAlign('center').run()"
        :class="{ 'is-active': editor.isActive({ textAlign: 'center' }) }"
      >
        <v-icon icon="mdi-format-align-center"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.align.center") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().setTextAlign('right').run()"
        :class="{ 'is-active': editor.isActive({ textAlign: 'right' }) }"
      >
        <v-icon icon="mdi-format-align-right"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.align.right") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().setTextAlign('justify').run()"
        :class="{ 'is-active': editor.isActive({ textAlign: 'justify' }) }"
      >
        <v-icon icon="mdi-format-align-justify"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.align.justify") }}
        </v-tooltip>
      </button>
      <div class="toolDivider"></div>
      <!-- 代码 -->
      <button
        @click="editor.chain().focus().toggleCode().run()"
        :disabled="!editor.can().chain().focus().toggleCode().run()"
        :class="{ 'is-active': editor.isActive('code') }"
      >
        <v-icon icon="mdi-code-tags"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.code") }}
        </v-tooltip>
      </button>
      <!-- 插入连接 -->
      <button
        @click="setLink()"
        :class="{ 'is-active': editor.isActive('link') }"
      >
        <v-icon icon="mdi-link"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.link") }}
        </v-tooltip>
      </button>
      <!-- 项目符号列表 -->
      <button
        @click="editor.chain().focus().toggleBulletList().run()"
        :class="{ 'is-active': editor.isActive('bulletList') }"
      >
        <v-icon icon="mdi-format-list-bulleted"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.bulletlist") }}
        </v-tooltip>
      </button>
      <!-- 数字列表 -->
      <button
        @click="editor.chain().focus().toggleOrderedList().run()"
        :class="{ 'is-active': editor.isActive('orderedList') }"
      >
        <v-icon icon="mdi-format-list-numbered"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.orderedlist") }}
        </v-tooltip>
      </button>
      <!-- 块引用 -->
      <button
        @click="editor.chain().focus().toggleBlockquote().run()"
        :class="{ 'is-active': editor.isActive('blockquote') }"
      >
        <v-icon icon="mdi-format-quote-close"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.blockquote") }}
        </v-tooltip>
      </button>
      <!-- 水平线 -->
      <button @click="editor.chain().focus().setHorizontalRule().run()">
        <v-icon icon="mdi-minus"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.horizontalrule") }}
        </v-tooltip>
      </button>
      <!-- 换行 -->
      <button @click="editor.chain().focus().setHardBreak().run()">
        <v-icon icon="mdi-format-text-wrapping-wrap"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.hardbreak") }}
        </v-tooltip>
      </button>
      <!-- 下标 -->
      <button
        @click="editor.chain().focus().toggleSubscript().run()"
        :class="{ 'is-active': editor.isActive('subscript') }"
      >
        <v-icon icon="mdi-format-subscript"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.subscript") }}
        </v-tooltip>
      </button>
      <!-- 上标 -->
      <button
        @click="editor.chain().focus().toggleSuperscript().run()"
        :class="{ 'is-active': editor.isActive('superscript') }"
      >
        <v-icon icon="mdi-format-superscript"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.superscript") }}
        </v-tooltip>
      </button>
      <!-- 插入图片 -->
      <button @click="addImage">
        <v-icon icon="mdi-image"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.insertImage") }}
        </v-tooltip>
      </button>
      <div class="toolDivider"></div>
      <!-- 表格 -->
      <button
        @click="
          editor
            .chain()
            .focus()
            .insertTable({ rows: 3, cols: 3, withHeaderRow: true })
            .run()
        "
      >
        <v-icon icon="mdi-table"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.insertTable") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().fixTables().run()"
        :disabled="!editor.can().fixTables()"
      >
        <v-icon icon="mdi-table-check"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.fixTables") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().addColumnBefore().run()"
        :disabled="!editor.can().addColumnBefore()"
      >
        <v-icon icon="mdi-table-column-plus-before"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.addColumnBefore") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().addColumnAfter().run()"
        :disabled="!editor.can().addColumnAfter()"
      >
        <v-icon icon="mdi-table-column-plus-after"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.addColumnAfter") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().deleteColumn().run()"
        :disabled="!editor.can().deleteColumn()"
      >
        <v-icon icon="mdi-table-column-remove"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.deleteColumn") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().addRowBefore().run()"
        :disabled="!editor.can().addRowBefore()"
      >
        <v-icon icon="mdi-table-row-plus-before"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.addRowBefore") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().addRowAfter().run()"
        :disabled="!editor.can().addRowAfter()"
      >
        <v-icon icon="mdi-table-row-plus-after"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.addRowAfter") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().deleteRow().run()"
        :disabled="!editor.can().deleteRow()"
      >
        <v-icon icon="mdi-table-row-remove"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.deleteRow") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().deleteTable().run()"
        :disabled="!editor.can().deleteTable()"
      >
        <v-icon icon="mdi-table-remove"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.deleteTable") }}
        </v-tooltip>
      </button>
      <!-- <button
        @click="editor.chain().focus().mergeCells().run()"
        :disabled="!editor.can().mergeCells()"
      >
        <v-icon icon="mdi-table-merge-cells"></v-icon>
        <v-tooltip activator="parent" location="top">
{{$t("editor.tooltip.italic")}}
</v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().splitCell().run()"
        :disabled="!editor.can().splitCell()"
      >
        <v-icon icon="mdi-table-split-cell"></v-icon>
        <v-tooltip activator="parent" location="top">
{{$t("editor.tooltip.italic")}}
</v-tooltip>
      </button> -->
      <button
        @click="editor.chain().focus().mergeOrSplit().run()"
        :disabled="!editor.can().mergeOrSplit()"
      >
        <v-icon
          v-if="editor.can().mergeCells()"
          icon="mdi-table-merge-cells"
        ></v-icon>
        <v-icon v-else icon="mdi-table-split-cell"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.mergeCells") }}
        </v-tooltip>
      </button>
      <!-- <button
        @click="editor.chain().focus().toggleHeaderColumn().run()"
        :disabled="!editor.can().toggleHeaderColumn()"
      >
        <v-icon icon="mdi-table-headers-eye"></v-icon>
        <v-tooltip activator="parent" location="top">
{{$t("editor.tooltip.italic")}}
</v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().toggleHeaderRow().run()"
        :disabled="!editor.can().toggleHeaderRow()"
      >
        <v-icon icon="mdi-table-headers-eye"></v-icon>
        <v-tooltip activator="parent" location="top">
{{$t("editor.tooltip.italic")}}
</v-tooltip>
      </button> -->
      <button
        @click="editor.chain().focus().toggleHeaderCell().run()"
        :disabled="!editor.can().toggleHeaderCell()"
      >
        <v-icon icon="mdi-table-headers-eye"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.toggleHeaderCell") }}
        </v-tooltip>
      </button>
      <button
        @click="
          editor
            .chain()
            .focus()
            .setCellAttribute('backgroundColor', '#FAF594')
            .run()
        "
        :disabled="!editor.can().setCellAttribute('backgroundColor', '#FAF594')"
      >
        <v-icon icon="mdi-table-star"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.setCellAttribute") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().goToPreviousCell().run()"
        :disabled="!editor.can().goToPreviousCell()"
      >
        <v-icon icon="mdi-table-arrow-left"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.goToPreviousCell") }}
        </v-tooltip>
      </button>
      <button
        @click="editor.chain().focus().goToNextCell().run()"
        :disabled="!editor.can().goToNextCell()"
      >
        <v-icon icon="mdi-table-arrow-right"></v-icon>
        <v-tooltip activator="parent" location="top">
          {{ $t("editor.tooltip.goToNextCell") }}
        </v-tooltip>
      </button>
    </div>
    <editor-content :editor="editor" />
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import { Editor, EditorContent } from "@tiptap/vue-3";
import StarterKit from "@tiptap/starter-kit";
import Underline from "@tiptap/extension-underline";
import TextStyle from "@tiptap/extension-text-style";
import { Color } from "@tiptap/extension-color";
import Table from "@tiptap/extension-table";
import TableCell from "@tiptap/extension-table-cell";
import TableHeader from "@tiptap/extension-table-header";
import TableRow from "@tiptap/extension-table-row";
import Image from "@tiptap/extension-image";
import Highlight from "@tiptap/extension-highlight";
import TextAlign from "@tiptap/extension-text-align";
import Typography from "@tiptap/extension-typography";
import Link from "@tiptap/extension-link";
import Subscript from "@tiptap/extension-subscript";
import Superscript from "@tiptap/extension-superscript";

import { ColorHighlighter } from "./tiptapPlus/ColorHighlighter";
import { SmilieReplacer } from "./tiptapPlus/SmilieReplacer";

import "prosemirror-view/style/prosemirror.css";

const CustomTableCell = TableCell.extend({
  addAttributes() {
    return {
      // extend the existing attributes …
      ...this.parent?.(),

      // and add a new one …
      backgroundColor: {
        default: null,
        parseHTML: (element) => element.getAttribute("data-background-color"),
        renderHTML: (attributes) => {
          return {
            "data-background-color": attributes.backgroundColor,
            style: `background-color: ${attributes.backgroundColor}`,
          };
        },
      },
    };
  },
});
export default defineComponent({
  name: "Editor",
  props: {
    modelValue: {
      type: String,
      required: true,
    },
  },
  components: {
    EditorContent,
  },
  emits: ["update:modelValue"],
  setup(props, { emit }) {
    const textColorDialog = ref(false);
    const textColor = ref("#000000");
    const heightlightColorDialog = ref(false);
    const heightlightColor = ref("#faf594");
    const pickerColor = ref("#faf594");
    const editor = new Editor({
      extensions: [
        StarterKit,
        Underline,
        TextStyle,
        Color,
        Table.configure({
          resizable: true,
        }),
        TableRow,
        TableHeader,
        CustomTableCell,
        Image,
        TextAlign.configure({
          types: ["heading", "paragraph"],
        }),
        Highlight.configure({ multicolor: true }),
        Typography,
        ColorHighlighter,
        SmilieReplacer,
        Link.configure({
          validate: (href) => /^https?:\/\//.test(href),
        }),
        Subscript,
        Superscript,
      ],
      content: props.modelValue,
      onUpdate: ({ editor }) => {
        emit("update:modelValue", editor.getHTML());
      },
      autofocus: false,
      onFocus: () => {
        console.log("focus");
      },
      editable: true,
      injectCSS: false,
      editorProps: {
        attributes: {
          spellcheck: "false",
        },
      },
    });

    return {
      textColorDialog,
      textColor,
      heightlightColorDialog,
      heightlightColor,
      pickerColor,
      editor,
    };
  },
  methods: {
    setBold() {
      this.editor.chain().focus().toggleOrderedList().run();
    },
    addImage() {
      const inputfile = document.createElement("input");
      inputfile.className = "inputFiles";
      inputfile.type = "file";
      inputfile.accept = "image/*";
      inputfile.addEventListener("change", async () => {
        const files = inputfile.files;
        if (files) {
          const file = files[0];
          const arrayBuffer = await file.arrayBuffer();
          const blob = new Blob([arrayBuffer], {
            type: file.type,
          });
          this.editor
            .chain()
            .focus()
            .setImage({ src: URL.createObjectURL(blob) })
            .run();
        }
        const inputFs = document.getElementsByClassName("inputFiles");
        for (const fi in inputFs) {
          if (Object.prototype.hasOwnProperty.call(inputFs, fi)) {
            const element = inputFs[fi];
            element.remove();
          }
        }
        inputfile.remove();
      });
      inputfile.click();
    },
    setLink() {
      const previousUrl = this.editor.getAttributes("link").href;
      if (previousUrl != undefined) {
        this.editor.chain().focus().unsetLink().run();
        return;
      }
      const url = window.prompt("URL", previousUrl);

      // cancelled
      if (url === null) {
        return;
      }

      // empty
      if (url === "") {
        this.editor.chain().focus().extendMarkRange("link").unsetLink().run();

        return;
      }

      // update link
      this.editor
        .chain()
        .focus()
        .extendMarkRange("link")
        .setLink({ href: url })
        .run();
    },
    setTextColor() {
      this.textColorDialog = !this.textColorDialog;
      this.textColor = this.pickerColor;
      console.log(this.textColor);
    },
    setheightlightColor() {
      this.heightlightColorDialog = !this.heightlightColorDialog;
      this.heightlightColor = this.pickerColor;
      console.log(this.heightlightColor);
    },
  },
});
</script>

<style scoped>
.editorView {
  width: 100%;
  min-height: 150px;
  background-color: #fff;
  border: 1px solid #9b9b9b;
  border-radius: 8px;
  overflow: hidden;
}

.editorView .toolbar {
  width: 100%;
  min-height: 80px;
  padding: 0 10px 10px 10px;
  background-color: #ebebeb;
  overflow: hidden;
  text-align: left;
  box-shadow: 0px 2px 5px #c2c2c2;
}

.editorView .toolbar button {
  width: 25px;
  height: 25px;
  color: #000;
  border-radius: 4px;
  margin-top: 10px;
  margin-right: 3px;
  position: relative;
}
.editorView .toolbar .combination {
  border-radius: 5px;
  padding: 2px 0px 4px 0px;
  border: 1px solid transparent;
}
.editorView .toolbar .combination:hover {
  border: 1px solid #c2c2c2;
}
.editorView .toolbar .combination .colorindicator {
  width: calc(100% - 4px);
  height: 5px;
  position: absolute;
  bottom: 0;
  left: 0;
  margin: 0 2px;
  border: 1px solid #b9b9b9;
}

.editorView .toolbar .selectColor {
  width: 15px;
  /* background-color: #fe7e7e; */
}

.editorView .toolbar .selectColor i {
  width: 10px;
}

.editorView .toolbar button:hover,
.editorView .toolbar .selectColor:hover {
  background-color: var(--button-background-color);
}

.is-active {
  background-color: var(--button-background-color);
  color: #000;
}

[disabled] {
  background-color: var(--button-background-color);
  color: #000;
}

.toolDivider {
  height: 20px;
  margin: 0 5px;
  display: inline-block;
  vertical-align: middle;
  width: 1px;
  height: 18px;
  background-color: #acacac;
}

.colorDialog {
  background-color: #fff;
}

.colorDialog .confirm {
  float: right;
  margin: 8px;
}
</style>
<style>
:root {
  --button-background-color: #cfcfcf;
}
.v-overlay__scrim {
  background: transparent !important;
}
.ProseMirror-focused {
  outline: none;
}

.tiptap {
  padding: 1rem 1rem;
  max-height: 400px;
  overflow-x: hidden;
  overflow-y: auto;
}
.tiptap > * + * {
  margin-top: 0.75em;
  text-align: left;
}
.tiptap::-webkit-scrollbar {
  width: 0.4em;
  height: 0.4em;
  border-radius: 10px;
}
.tiptap::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 10px;
}
.tiptap::-webkit-scrollbar-thumb {
  background: #888;
  border-radius: 10px;
}

.tiptap p {
  /* margin: 0; */
  text-align: left;
}

.tiptap ul,
.tiptap ol {
  padding: 0 1rem;
}

.tiptap h1,
.tiptap h2,
.tiptap h3,
.tiptap h4,
.tiptap h5,
.tiptap h6 {
  line-height: 1.1;
}

.tiptap code {
  background-color: rgba(97, 97, 97, 0.1);
  color: #616161;
}

.tiptap pre {
  background: #0d0d0d;
  color: #fff;
  font-family: "JetBrainsMono", monospace;
  padding: 0.75rem 1rem;
  border-radius: 0.5rem;
}

.tiptap pre code {
  color: inherit;
  padding: 0;
  background: none;
  font-size: 0.8rem;
}

.tiptap mark {
  background-color: #faf594;
}

.tiptap img {
  max-width: 100%;
  height: auto;
}

.tiptap blockquote {
  padding-left: 1rem;
  border-left: 2px solid rgba(13, 13, 13, 0.1);
}

.tiptap hr {
  border: none;
  border-top: 2px solid rgba(13, 13, 13, 0.1);
  margin: 2rem 0;
}

.tiptap table {
  border-collapse: collapse;
  table-layout: fixed;
  width: 100%;
  margin: 0;
  overflow: hidden;
}

.tiptap td,
.tiptap th {
  min-width: 1em;
  border: 2px solid #ced4da;
  padding: 3px 5px;
  vertical-align: top;
  box-sizing: border-box;
  position: relative;
}

.tiptap td > *:first-child,
.tiptap th > *:first-child {
  margin-top: 0;
}

.tiptap th {
  font-weight: bold;
  text-align: left;
  background-color: #f1f3f5;
}

.tiptap .selectedCell:after {
  z-index: 2;
  position: absolute;
  content: "";
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  background: rgba(200, 200, 255, 0.4);
  pointer-events: none;
}

.tiptap .column-resize-handle {
  position: absolute;
  right: -2px;
  top: 0;
  bottom: -2px;
  width: 4px;
  background-color: #adf;
  pointer-events: none;
}

.tiptap .color {
  white-space: nowrap;
}

.tiptap .color::before {
  content: " ";
  display: inline-block;
  width: 1em;
  height: 1em;
  border: 1px solid rgba(128, 128, 128, 0.3);
  vertical-align: middle;
  margin-right: 0.1em;
  margin-bottom: 0.15em;
  border-radius: 2px;
  background-color: var(--color);
}

.tiptap .tableWrapper {
  overflow-x: auto;
}

.tiptap .resize-cursor {
  cursor: ew-resize;
  cursor: col-resize;
}
</style>
<!-- <style lang="scss">
/* Basic editor styles */
.tiptap {
  margin: 1rem 0;
  padding: 0 15px;

  > * + * {
    margin-top: 0.75em;
    text-align: left;
  }

  ul,
  ol {
    padding: 0 1rem;
  }

  h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    line-height: 1.1;
  }

  code {
    background-color: rgba(#616161, 0.1);
    color: #616161;
  }

  pre {
    background: #0d0d0d;
    color: #fff;
    font-family: "JetBrainsMono", monospace;
    padding: 0.75rem 1rem;
    border-radius: 0.5rem;

    code {
      color: inherit;
      padding: 0;
      background: none;
      font-size: 0.8rem;
    }
  }

  mark {
    background-color: #faf594;
  }

  img {
    max-width: 100%;
    height: auto;
  }

  blockquote {
    padding-left: 1rem;
    border-left: 2px solid rgba(#0d0d0d, 0.1);
  }

  hr {
    border: none;
    border-top: 2px solid rgba(#0d0d0d, 0.1);
    margin: 2rem 0;
  }

  table {
    border-collapse: collapse;
    table-layout: fixed;
    width: 100%;
    margin: 0;
    overflow: hidden;

    td,
    th {
      min-width: 1em;
      border: 2px solid #ced4da;
      padding: 3px 5px;
      vertical-align: top;
      box-sizing: border-box;
      position: relative;

      > * {
        margin-bottom: 0;
      }
    }

    th {
      font-weight: bold;
      text-align: left;
      background-color: #f1f3f5;
    }

    .selectedCell:after {
      z-index: 2;
      position: absolute;
      content: "";
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      background: rgba(200, 200, 255, 0.4);
      pointer-events: none;
    }

    .column-resize-handle {
      position: absolute;
      right: -2px;
      top: 0;
      bottom: -2px;
      width: 4px;
      background-color: #adf;
      pointer-events: none;
    }

    p {
      margin: 0;
      text-align: left;
    }
  }
}

.color {
  white-space: nowrap;

  &::before {
    content: " ";
    display: inline-block;
    width: 1em;
    height: 1em;
    border: 1px solid rgba(128, 128, 128, 0.3);
    vertical-align: middle;
    margin-right: 0.1em;
    margin-bottom: 0.15em;
    border-radius: 2px;
    background-color: var(--color);
  }
}

.tableWrapper {
  overflow-x: auto;
}

.resize-cursor {
  cursor: ew-resize;
  cursor: col-resize;
}
</style> -->
