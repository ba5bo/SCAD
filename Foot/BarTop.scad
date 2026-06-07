// BarTop - 顶部装饰件
// 结构：底部圆柱(直径29mm, 高10mm) + 中部圆柱(直径34mm, 高5mm) + 球顶

$fn = 60; // 平滑度设置

// 参数定义
bottom_diameter = 29;    // 底部圆柱直径
bottom_height = 10;      // 底部圆柱高度
middle_diameter = 34;    // 中部圆柱直径
middle_height = 5;       // 中部圆柱高度
sphere_radius = middle_diameter / 2; // 球顶半径（与中部圆柱直径相同）

module BarTop() {
    // 底部圆柱
    cylinder(d = bottom_diameter, h = bottom_height);
    
    // 中部圆柱（叠加在底部圆柱上）
    translate([0, 0, bottom_height]) {
        cylinder(d = middle_diameter, h = middle_height+3);
    }
    
    // 球顶（叠加在中部圆柱上）
    translate([0, 0, bottom_height + middle_height+4]) {
        sphere(r = sphere_radius);
    }
}

// 渲染模型
BarTop();
