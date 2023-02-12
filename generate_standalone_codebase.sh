#!/bin/bash

OUTDIR="$1"
if [ -z $OUTDIR ]; then
    OUTDIR="output"
fi

mkdir -p "$OUTDIR"
mkdir -p "$OUTDIR/parallel-rdp"
mkdir -p "$OUTDIR/parallel-rdp/shaders"
mkdir -p "$OUTDIR/vulkan"
mkdir -p "$OUTDIR/vulkan-headers/include/vulkan"
mkdir -p "$OUTDIR/vulkan-headers/include/vk_video"
mkdir -p "$OUTDIR/util"
mkdir -p "$OUTDIR/volk"

echo `git rev-parse HEAD` > "$OUTDIR/COMMIT"
cp -v LICENSE "$OUTDIR/"
cp -v README.md "$OUTDIR/"
cp -v parallel-rdp/*.cpp "$OUTDIR/parallel-rdp/"
cp -v parallel-rdp/*.hpp "$OUTDIR/parallel-rdp/"
cp -v parallel-rdp/shaders/*.comp "$OUTDIR/parallel-rdp/shaders/"
cp -v parallel-rdp/shaders/*.vert "$OUTDIR/parallel-rdp/shaders/"
cp -v parallel-rdp/shaders/*.frag "$OUTDIR/parallel-rdp/shaders/"
cp -v parallel-rdp/shaders/*.h "$OUTDIR/parallel-rdp/shaders/"
cp -v parallel-rdp/shaders/*.json "$OUTDIR/parallel-rdp/shaders/"
cp -v Granite/util/aligned_alloc.cpp "$OUTDIR/util/"
cp -v Granite/util/arena_allocator.cpp "$OUTDIR/util/"
cp -v Granite/util/timer.cpp "$OUTDIR/util/"
cp -v Granite/util/aligned_alloc.hpp "$OUTDIR/util/"
cp -v Granite/util/arena_allocator.hpp "$OUTDIR/util/"
cp -v Granite/util/timer.hpp "$OUTDIR/util/"
cp -v Granite/util/bitops.hpp "$OUTDIR/util/"
cp -v Granite/util/enum_cast.hpp "$OUTDIR/util/"
cp -v Granite/util/hash.hpp "$OUTDIR/util/"
cp -v Granite/util/intrusive.hpp "$OUTDIR/util/"
cp -v Granite/util/intrusive_hash_map.hpp "$OUTDIR/util/"
cp -v Granite/util/intrusive_list.hpp "$OUTDIR/util/"
cp -v Granite/util/logging.hpp "$OUTDIR/util/"
cp -v Granite/util/logging.cpp "$OUTDIR/util/"
cp -v Granite/util/object_pool.hpp "$OUTDIR/util/"
cp -v Granite/util/read_write_lock.hpp "$OUTDIR/util/"
cp -v Granite/util/small_vector.hpp "$OUTDIR/util/"
cp -v Granite/util/stack_allocator.hpp "$OUTDIR/util/"
cp -v Granite/util/temporary_hashmap.hpp "$OUTDIR/util/"
cp -v Granite/util/timeline_trace_file.* "$OUTDIR/util/"
cp -v Granite/util/thread_name.* "$OUTDIR/util/"
cp -v Granite/util/thread_id.* "$OUTDIR/util/"
cp -v Granite/third_party/volk/volk.h "$OUTDIR/volk/"
cp -v Granite/third_party/volk/volk.c "$OUTDIR/volk/"
cp -v Granite/vulkan/*.cpp "$OUTDIR/vulkan/"
cp -v Granite/vulkan/*.hpp "$OUTDIR/vulkan/"
cp -v Granite/vulkan/texture/texture_format.* "$OUTDIR/vulkan/"
cp -v Granite/third_party/khronos/vulkan-headers/include/vulkan/*.h "$OUTDIR/vulkan-headers/include/vulkan"
cp -v Granite/third_party/khronos/vulkan-headers/include/vk_video/*.h "$OUTDIR/vulkan-headers/include/vk_video"
cp -v parallel-rdp/config.mk "$OUTDIR/config.mk"

echo "=== Compiling to SPIR-V ... ==="
slangmosh --vk11 --strip -O --namespace RDP parallel-rdp/shaders/slangmosh.json --output "$OUTDIR/parallel-rdp/shaders/slangmosh.hpp"
echo "=== Done! ==="
