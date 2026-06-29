// DrugShelf.scad - 6槽U型架，用于倒挂安装在柜子顶部
// 从侧面看是UUUUUU形状，前后开放，底部带安装耳朵
// 倒挂安装：耳朵在底部（Z=0处）用于固定

// 参数定义
wall_thickness = 3;           // 壁厚3mm
slot_internal_width = 10;     // U型槽内宽10mm（有效空间）
slot_height = 70;             // U型槽高度70mm（有效空间）
total_depth = 85;             // 总体深度85mm（有效空间）
num_slots = 15;               // 15组U型槽（最大，总宽238mm）
ear_width = 20;               // 耳朵宽度2cm=20mm
ear_height = 3;               // 耳朵高度3mm
screw_hole_diameter = 5.2;    // M4螺丝孔直径(留打印误差空间)
notch_depth_y = 28;           // 单边口Y轴方向深度28mm（约1/3总深度85mm）
notch_width = 2;              // 单边口宽度2mm

// 计算总宽度
slot_spacing = slot_internal_width + wall_thickness;  // 槽间距（内宽+壁厚）
total_width = 2 * ear_width + wall_thickness + num_slots * slot_spacing;

// 主体模块 - U型架主体（前后开放，从侧面看是UUUUUU）
module shelf_body() {
    difference() {
        union() {
            // 中间U型槽区域的底板（只在U型槽区域，不包括耳朵）
            translate([ear_width, 0, 0])
                cube([total_width - 2 * ear_width, total_depth, wall_thickness]);
            
            // 左侧壁 + 耳朵一体结构（倒L型）
            union() {
                // 左侧壁（从底部Z=0到Z=23）
                translate([ear_width, 0, 0])
                    cube([wall_thickness, total_depth, slot_height + wall_thickness]);
                // 左耳朵（在左壁顶部向外延伸，顶面与中间隔板齐平Z=23）
                translate([-1, -1, slot_height])
                    cube([ear_width + wall_thickness + 1, total_depth + 2, ear_height]);
            }
            
            // 右侧壁 + 耳朵一体结构（倒L型）
            union() {
                // 右侧壁（从底部Z=0到Z=23）
                translate([total_width - ear_width - wall_thickness, 0, 0])
                    cube([wall_thickness, total_depth, slot_height + wall_thickness]);
                // 右耳朵（在右壁顶部向外延伸，顶面与中间隔板齐平Z=23）
                translate([total_width - ear_width - wall_thickness, -1, slot_height])
                    cube([ear_width + wall_thickness + 1, total_depth + 2, ear_height]);
            }
            
            // 中间隔板（5个分隔6个U型槽，从底板Z=3到Z=23）
            for (i = [1 : num_slots - 1]) {
                translate([ear_width + wall_thickness + i * slot_spacing - wall_thickness, 0, wall_thickness])
                    cube([wall_thickness, total_depth, slot_height]);
            }
            
            // 中间隔板顶部粘接壁（5个，从Z=21到Z=23，宽度10mm，厚度2mm）
            for (i = [1 : num_slots - 1]) {
                x_pos = ear_width + wall_thickness + i * slot_spacing - wall_thickness;
                // 粘接壁居中于隔板，向两侧各延伸(10-3)/2 = 3.5mm
                translate([x_pos - 3.5, 0, slot_height + wall_thickness - 2])
                    cube([10, total_depth, 2]);
            }
        }
        
        // 在每个U型槽底部前侧创建单边口
        for (i = [0 : num_slots - 1]) {
            x_pos = ear_width + wall_thickness + i * slot_spacing;
            // 在U型槽底部中心位置创建缺口
            // Y轴：从前面挖1/3深度（20mm），超出边界
            // Z轴：从Z=-1到Z=wall_thickness+1，完全穿透3mm底板并超出
            translate([
                x_pos + slot_internal_width / 2 - notch_width / 2, 
                -1, 
                -1
            ])
                cube([notch_width, notch_depth_y + 2, wall_thickness + 3]);
        }
        
        // 左侧耳朵螺丝孔（Z轴方向垂直穿过耳朵）
        // 耳朵在Z=20到Z=23，螺丝孔中心在Z=21.5
        translate([ear_width / 2, 15, slot_height + ear_height / 2])
            cylinder(h = ear_height + 4, d = screw_hole_diameter, $fn=30, center = true);
        translate([ear_width / 2, total_depth - 15, slot_height + ear_height / 2])
            cylinder(h = ear_height + 4, d = screw_hole_diameter, $fn=30, center = true);
        
        // 右侧耳朵螺丝孔（Z轴方向垂直穿过耳朵）
        translate([total_width - ear_width / 2, 15, slot_height + ear_height / 2])
            cylinder(h = ear_height + 4, d = screw_hole_diameter, $fn=30, center = true);
        translate([total_width - ear_width / 2, total_depth - 15, slot_height + ear_height / 2])
            cylinder(h = ear_height + 4, d = screw_hole_diameter, $fn=30, center = true);
    }
}

// 渲染完整架子
shelf_body();

// 显示尺寸信息
echo(str("总宽度: ", total_width, "mm"));
echo(str("总深度: ", total_depth, "mm"));
echo(str("总高度: ", slot_height + wall_thickness + ear_height, "mm"));
echo(str("单个U型槽内宽: ", slot_internal_width, "mm"));
echo(str("U型槽高度: ", slot_height, "mm"));
echo(str("耳朵宽度: ", ear_width, "mm"));
echo(str("耳朵高度: ", ear_height, "mm"));
