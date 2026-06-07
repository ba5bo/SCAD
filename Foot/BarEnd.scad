// BarEnd - 自行车把塞设计
// 结构：23mm直径15mm高圆柱 + 27mm直径5mm圆柱 + 27mm直径5mm球面顶

$fn = 60; // 圆滑度

module BarEnd() {
    // 底部圆柱：23mm直径，15mm高
    cylinder(d=23, h=15);
    
    // 中间圆柱：27mm直径，5mm高
    translate([0, 0, 15])
        cylinder(d=26, h=6);
    
    // 顶部球面：27mm直径，5mm高（半球）
    translate([0, 0, 21.7])
        sphere(d=26);
}

// 渲染模型
BarEnd();
