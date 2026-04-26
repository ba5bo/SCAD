// ColumnStand - 台阶状圆柱设计
// 最小外径29mm，高度18mm
// 第二级外径40mm，高度20mm
// 整体打一个20mm的通孔
// 最下面一级对称6等分10x10的半圆径向开槽

$fn = 100; // 提高渲染精度

// 参数定义
min_diameter = 29;      // 最小外径
min_height = 18;        // 第一级高度
second_diameter = 40;   // 第二级外径
second_height = 20;     // 第二级高度
hole_diameter = 20;     // 通孔直径
slot_width = 10;        // 开槽宽度
slot_depth = 10;        // 开槽深度（半径方向）
num_slots = 6;          // 开槽数量（6等分）

// 创建台阶状圆柱主体
difference() {
    // 主体：两级圆柱
    union() {
        // 第一级圆柱（底部）
        cylinder(
            h = min_height,
            d = min_diameter,
            center = false
        );
        
        // 第二级圆柱（顶部）
        translate([0, 0, min_height]) {
            cylinder(
                h = second_height,
                d = second_diameter,
                center = false
            );
        }
    }
    
    // 中心通孔（上下都超出以修正计算误差）
    translate([0, 0, -2]) {
        cylinder(
            h = min_height + second_height + 4,  // 增加高度余量，上下各超出2mm
            d = hole_diameter,
            center = false
        );
    }
    
    // 在第二级（粗的一侧）顶部端面创建6个径向开槽（用3个贯穿的半圆柱）
    for (i = [0:2]) {
        rotate([0, 0, i * 60]) {
            // 创建贯穿的半圆形开槽（沿X轴方向，半圆朝下）
            translate([0, 0, min_height + second_height + 0.5]) {  // 稍微往上移动0.5mm避免叠加误差
                intersection() {
                    // 沿X轴的圆柱体
                    rotate([0, 90, 0]) {
                        cylinder(
                            h = second_diameter + 2,
                            r = slot_width/2,
                            center = true
                        );
                    }
                    // 用长方体切割成半圆（只保留下半部分，z<0的部分）
                    translate([0, 0, -slot_width/4]) {
                        cube([second_diameter + 2, slot_width, slot_width/2], center = true);
                    }
                }
            }
        }
    }
}
