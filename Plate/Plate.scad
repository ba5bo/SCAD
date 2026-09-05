// 浅盘 (Shallow Plate) - 折边设计
// 底部外径: 14cm (140mm)
// 高度: 3cm (30mm)
// 顶部开口内径: 16cm (160mm)
// 折边外径: 17cm (170mm)
// 壁厚: 1.6mm

$fn = 120;

// === 参数 ===
bottom_outer_d = 140;       // 底部外径 mm
top_inner_d    = 160;       // 顶部开口内径 mm
rim_outer_d    = 170;       // 折边外径 mm
total_height   = 30;        // 总高度 mm
wall_thickness = 1.6;       // 壁厚 mm

// === 派生尺寸 ===
R_bo = bottom_outer_d / 2;              // 底部外半径 70mm
R_to = rim_outer_d / 2;                 // 折边外半径 85mm
R_ti = top_inner_d / 2;                 // 顶部内半径 80mm
R_bi = R_bo - wall_thickness;           // 底部内半径 68.4mm
inner_depth = total_height - wall_thickness; // 内部深度 28.4mm

// 均匀壁厚锥体: 内外锥面平行
slope = (R_ti - R_bi) / inner_depth;    // 锥面斜率 0.4085
R_body_top = R_bo + slope * total_height;  // 锥顶外半径 82.25mm
R_fold_inner = R_bo + slope * inner_depth; // 折边内半径 81.6mm

// === 模型 ===
difference() {
    union() {
        // 1. 锥体主体: 均匀壁厚1.6mm
        cylinder(r1 = R_bo, r2 = R_body_top, h = total_height);

        // 2. 折边: 从外壁顶部向外水平展开, 厚1.6mm
        translate([0, 0, inner_depth])
            difference() {
                cylinder(r = R_to, h = wall_thickness + 0.01);
                translate([0, 0, -0.01])
                    cylinder(r = R_fold_inner, h = wall_thickness + 0.03);
            }
    }

    // 内部锥台空腔: 底部R_bi → 顶部R_ti, 底部留1.6mm
    translate([0, 0, wall_thickness])
        cylinder(r1 = R_bi, r2 = R_ti, h = inner_depth + 0.01);
}
