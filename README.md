# 机器学习实验报告 Typst 模板

供同学编写机器学习实验报告使用。模板提供封面、自动目录、实验正文排版，以及图、表、代码和公式的编号与引用。编辑 `main.typ` 即可开始写报告；`use.typ` 是可编译的详细使用指南。

## 模板拉取

已安装 Git 的同学，可以在终端运行：

```sh
git clone https://github.com/043520lxy-cmd/typst-ml-lab-report-template.git
cd typst-ml-lab-report-template
```

以后需要获取仓库更新时，进入该目录运行 `git pull`。不使用 Git 的同学，可在仓库页面点击 **Code → Download ZIP**，解压后直接编辑 `main.typ`。

## 环境与使用

安装 [Typst](https://typst.app/) 后，在本目录运行：

```sh
typst compile main.typ
typst compile use.typ
```

命令分别生成 `main.pdf` 和 `use.pdf`。本模板已在 Typst 0.15.1 下编译通过。首次编译可能需要下载 `cuti` 包，请保持网络连接。

在 `main.typ` 顶部的 `machine-learning-report.with(...)` 中填写课程、学期、班级、学号、姓名、教师和日期，然后修改下面的实验正文。一级标题（`=`）表示一个实验，会自动进入目录；二级标题（`==`）表示实验内的小节。插图、表格、代码、公式和交叉引用的写法见 `use.typ`。

模板使用宋体、黑体、Times New Roman 等字体。不同系统的字体可能不同；若编译时提示缺少字体，请安装相应字体，或在 `utilities/report-style.typ` 和 `utilities/machine-learning-report.typ` 中调整字体设置。

## 文件结构

```text
.
├── main.typ                         # 实验报告入口，主要编辑此文件
├── use.typ                          # 可编译的使用指南和示例
├── refs.bib                         # 参考文献示例数据
├── figures/
│   ├── xinyu-university-logo.jpeg   # 当前封面使用的学校标志
│   ├── 示例图片1.png
│   └── 示例图片2.png
├── utilities/
│   ├── machine-learning-report.typ  # 封面、目录、页眉页脚和报告入口
│   ├── report-style.typ             # 正文、标题、公式及引用样式
│   ├── three-line-table.typ         # 三线表辅助函数
│   └── figure-table-numbering.typ   # 独立编号工具，当前入口未使用
├── licenses/
│   └── cumcm-muban-LICENSE          # 所改编第三方代码的许可证副本
├── THIRD_PARTY_NOTICES.md           # 第三方代码来源及修改说明
├── LICENSE                          # 项目代码和文档的 Apache-2.0 许可证
├── .gitignore
└── README.md
```

封面目前固定引用 `figures/xinyu-university-logo.jpeg`，并在 `utilities/machine-learning-report.typ` 中写有学院名称。用于其他学校或课程时，需要修改这两处内容。

本地编译生成的 PDF、含个人信息的 `第一次作业.typ` 及其结果图已由 `.gitignore` 排除，不属于仓库文件结构。

## 许可与第三方代码

除另有说明的素材外，本仓库的代码和文档按 [Apache License 2.0](LICENSE) 提供。正文样式部分改编自 `cumcm-muban`；其来源、修改说明及上游许可证副本见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

`figures/xinyu-university-logo.jpeg` 是封面使用的学校标志，不包含在本项目的 Apache-2.0 授权范围内；使用或替换时请遵循相应权利人的要求。
