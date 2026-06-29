// 浅盘 (Shallow Plate)
// 底部内径: 15cm (150mm)
// 高度: 3cm (30mm)
// 顶部开口内径: 17cm (170mm)
// 折边外径: 19cm (190mm)
// 折边宽: 1cm (10mm)
// 壁厚: 1.6mm (均匀)

$fn = 120;

// === 参数 ===
bottom_inner_d = 150;       // 底部内径 mm
total_height   = 30;        // 总高度 mm
top_inner_d    = 170;       // 顶部开口内径 mm
rim_outer_d    = 190;       // 折边外径 mm
wall_thickness = 1.6;       // 壁厚 mm

// === 派生尺寸 ===
R_bi = bottom_inner_d / 2;     // 底部内半径 75mm
R_ti = top_inner_d / 2;        // 顶部内半径 85mm
R_to = rim_outer_d / 2;        // 折边外半径 95mm
inner_depth = total_height - wall_thickness; // 内部深度 28.4mm

// 均匀壁厚: 内外锥面斜率相同
// 内锥斜率: (85-75)/28.4 = 0.352
// 外锥在z=0处半径=R_bi+wall_t, 在z=30处半径=R_bi+wall_t+斜率*30
// 折边从外锥顶部向外展平
slope = (R_ti - R_bi) / inner_depth;  // 内外锥均匀斜率
R_bo = R_bi + wall_thickness;         // 底部外半径 76.6mm
R_body_top_o = R_bo + slope * total_height; // 外锥顶部半径 87.16mm
R_fold_inner = R_bo + slope * inner_depth;  // 折边起始处外壁半径 86.6mm

// === 模型 ===
difference() {
    union() {
        // 1. 均匀壁厚锥体主体
        cylinder(r1 = R_bo, r2 = R_body_top_o, h = total_height);

        // 2. 折边: 从外壁顶部向外展开, 厚1.6mm
        translate([0, 0, inner_depth])
            difference() {
                cylinder(r = R_to, h = wall_thickness + 0.01);
                translate([0, 0, -0.01])
                    cylinder(r = R_fold_inner, h = wall_thickness + 0.03);
            }
    }

    // 内部锥台空腔: 与外侧平行, 均匀壁厚1.6mm
    translate([0, 0, wall_thickness])
        cylinder(r1 = R_bi, r2 = R_ti, h = inner_depth + 0.01);
}
