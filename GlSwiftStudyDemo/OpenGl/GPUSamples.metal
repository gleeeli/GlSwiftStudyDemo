//
//  GPUSamples.metal
//  GlSwiftStudyDemo
//
//  Created by liguanglei on 2024/6/26.
//  Copyright © 2024 gleeeli. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void add_arrays(device const float* inA,
                       device const float* inB,
                       device float* result,
                       uint index [[thread_position_in_grid]])
{
    // the for-loop is replaced with a collection of threads, each of which
    // calls this function.
    result[index] = inA[index] + inB[index];
}

