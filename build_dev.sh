#!/bin/bash
# 获取脚本的绝对路径
workdir=$(cd "$(dirname "$0")"; pwd)
# 切换到脚本所在目录
cd "$workdir"
# 在这里执行需要在脚本根目录下执行的命令
echo "当前工作目录：$(pwd)"
a7zip="$workdir/tools/7zzs"
Image_out_dir="$workdir/common/out/arch/arm64/boot"
branch="ChirunoNeko"
source "$workdir/function.sh"
build_date=$(date +%y%m%d)
export ARCH=arm64
export SUBARCH=arm64
export PATH="/home/morizukineko/toolchain/clang-r584948b/bin:$PATH"
export KBUILD_BUILD_HOST=NikoNeko-Studio
export KBUILD_BUILD_USER=NikoRur_QwQRuaa
export SOURCE_DATE_EPOCH=$(date +%s)
yellow "构建SukiSU+KPM版本"
make -j$(nproc --all) ARCH=arm64 LLVM=1 LLVM_IAS=1 O=out venus_defconfig && \
scripts/config --file out/.config -e LTO_CLANG -d LTO_NONE -e LTO_CLANG_THIN -d LTO_CLANG_FULL -e THINLTO && \
make -j$(nproc --all) ARCH=arm64 LLVM=1 LLVM_IAS=1 O=out modules Image
