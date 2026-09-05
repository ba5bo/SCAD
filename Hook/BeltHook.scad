$fn = 60;
R = 0.5;        // 所有独立直角边的圆角半径
MFN = 16;       // minkowski 球的分辨率（R0.5 圆角足够平滑，降低以提速）

// BeltHook：环形穿带扣（所有独立直角边——含端面棱——倒 R0.5，配合尺寸不变）
// 环：外框 59x19x6，内孔 50x3（Y 8~11 居中），壁厚 8
//   用「圆角立方体求差」构建：外框圆角立方体 → 12 条棱 + 上下端面棱全部 R0.5，尺寸精确
//   内孔 = 中段四角 R0.5（避开孔口倒角段）+ 方角直棱柱穿透消除共面 0 厚度 + 孔口 R0.5 外扩倒角
//   竖臂×环接合：底部用长方体填沟；顶部（环顶面×竖臂根部）与两端侧面（竖臂端面×环侧面）用 1/4 弧面过渡
// 钩子：C 形截面（开口朝 -Z），沿环长边方向（X）挤出 46，居中偏移 6.5
//   线厚 2（近侧竖臂调薄为 1.5 → 钩口颈 6.5、腔 10.5）
//   端面棱用「补偿 minkowski」倒 R0.5：截面内缩 R、长度减 2R，再与球 minkowski → 复原尺寸且圆化所有棱
//   开运算会把钩口 90° 内角还原成尖角，故内角用 inner_fillet 沿 X（两端各内缩 R）单独补回

// 圆角立方体：占据 [0,x]×[0,y]×[0,z]，全部棱倒圆 R r
module rounded_cube(x, y, z, r = R) {
    translate([r, r, r])
    minkowski() {
        cube([x - 2*r, y - 2*r, z - 2*r]);
        sphere(r = r, $fn = MFN);
    }
}

// 内凹角 R 填充（2D）：凹角处加 r×r 矩形，再减去圆心在凹口内侧的 1/4 圆
// (x,y)=凹角顶点，(dx,dy)=±1 指向凹口（空缺区）方向
module inner_fillet(x, y, dx, dy, r = R) {
    difference() {
        translate([dx > 0 ? x : x - r, dy > 0 ? y : y - r]) square([r, r]);
        translate([x + dx*r, y + dy*r]) circle(r = r);
    }
}

// 孔口倒角（顶 Z=6 面）：移除孔口凸边尖角 → 孔口向外扩 R0.5（与翻边收窄方向相反）
// 每条边 = 「方块 − 1/4 圆柱」沿边拉伸；方块两端各伸长 R 覆盖角点、向上伸出环面 0.5 避免共面
module hole_mouth_chamfer(r = R) {
    // Y=8 边（沿 X），圆柱心 (Y=7.5, Z=5.5)
    difference() {
        translate([4.5 - r, 8 - r, 6 - r]) cube([50 + 2*r, r, r + 0.5]);
        translate([4.5 - 2*r, 8 - r, 6 - r]) rotate([0, 90, 0]) cylinder(h = 50 + 4*r, r = r);
    }
    // Y=11 边（沿 X），圆柱心 (Y=11.5, Z=5.5)
    difference() {
        translate([4.5 - r, 11, 6 - r]) cube([50 + 2*r, r, r + 0.5]);
        translate([4.5 - 2*r, 11 + r, 6 - r]) rotate([0, 90, 0]) cylinder(h = 50 + 4*r, r = r);
    }
    // X=4.5 边（沿 Y），圆柱心 (X=4.0, Z=5.5)
    difference() {
        translate([4.5 - r, 8 - r, 6 - r]) cube([r, 3 + 2*r, r + 0.5]);
        translate([4.5 - r, 8 - 2*r, 6 - r]) rotate([-90, 0, 0]) cylinder(h = 3 + 4*r, r = r);
    }
    // X=54.5 边（沿 Y），圆柱心 (X=55.0, Z=5.5)
    difference() {
        translate([54.5, 8 - r, 6 - r]) cube([r, 3 + 2*r, r + 0.5]);
        translate([54.5 + r, 8 - 2*r, 6 - r]) rotate([-90, 0, 0]) cylinder(h = 3 + 4*r, r = r);
    }
}

// 钩子 2D 截面（局部 x→世界 Y-19，y→世界 Z）：原始尖角，圆化交给补偿 minkowski
module hook_section() {
    union() {
        square([1.5, 1.5]);   // 根部补平，与环 Y=19 面齐平、不成沟
        polygon([
            [0,8], [14,8], [14,-2], [8,-2], [8,0], [12,0], [12,6], [1.5,6],
            [1.5,0], [0,0]
        ]);
    }
}

union() {
    // ── 环：圆角立方体求差，外框所有棱 R0.5 ──
    difference() {
        rounded_cube(59, 19, 6);
        // 孔主体三段：中段 Z[0.5,5.5] 四角 R0.5（高度避开孔口倒角段，不与倒角叠加）；
        // 上下段 50×3 方角直棱柱穿透 Z[-1,7] 消除共面 0 厚度；
        // 孔口倒角（外扩方向）：移除孔口凸边尖角，孔口在环面上扩到 51×4，孔壁从 Z=0.5/5.5 圆弧过渡
        union() {
            translate([4.5, 8, R])
                linear_extrude(height = 6 - 2*R)
                offset(r = R) offset(r = -R) square([50, 3]);
            translate([4.5, 8, -1]) cube([50, 3, 1 + R]);
            translate([4.5, 8, 6 - R]) cube([50, 3, 1 + R]);
            hole_mouth_chamfer();
            translate([0, 0, 6]) mirror([0, 0, 1]) hole_mouth_chamfer();
        }
    }

    // ── 钩子：补偿 minkowski 圆化所有棱（含 X 两端端面棱），配合尺寸不变 ──
    minkowski() {
        translate([6.5 + R, 19, 0])
        rotate([90, 0, 90])
        linear_extrude(height = 46 - 2*R)
        offset(delta = -R)
        hook_section();
        sphere(r = R, $fn = MFN);
    }

    // ── 竖臂×环 Y=19 接合处填沟：两侧底部 R0.5 圆角在 (Y=19,Z=0) 拼出沿 X 的 V 沟，用长方体填满 ──
    // X∈[7,52] 两端各内缩 R 埋进钩子全截面；Y∈[18.5,20] 跨 Y=19 埋入环(≤19)与竖臂(≥19)；Z∈[0,1] 填底沟
    translate([7, 18.5, 0]) cube([45, 1.5, 1]);

    // ── 环顶面×竖臂根部内角：环顶棱 R0.5 圆角在接合段收出一条沿 X 的沟，填成 1/4 弧面过渡 ──
    // 截面（Y,Z）= 矩形 [18.5,20]×[5.5,6.5] − 1/4 圆(心 18.5,6.5)：下段填沟，上段形成
    // 从环顶面 (18.5,6) 到竖臂面 (19,6.5) 的 R0.5 圆弧；沿 X 拉伸，两端各内缩 R
    translate([6.5 + R, 0, 0])
    rotate([90, 0, 90])
    linear_extrude(height = 46 - 2*R)
    difference() {
        translate([18.5, 5.5]) square([1.5, 1]);
        translate([18.5, 6.5]) circle(r = R);
    }

    // ── 竖臂两端面×环侧面 Y=19 的 90° 内角：填成 1/4 弧面过渡（X=6.5 端与 X=52.5 端）──
    // 截面（X,Y）= 矩形 − 1/4 圆（圆心在凹口内）：弧从环侧面过渡到竖臂端面；
    // 矩形向钩子内侧多伸 R，一并盖过钩端面 R0.5 圆角在此收出的沟；
    // Z 仅拉伸 0.5→5.5（环侧面平面段）：去掉上下两边外棱圆角的高度，端面落在圆角切点上与之平滑过渡
    translate([0, 0, R])
    linear_extrude(height = 6 - 2*R)
    difference() {
        translate([6, 19]) square([1, 0.5]);      // 弧 (6,19)→(6.5,19.5)，盖到 X=7
        translate([6, 19.5]) circle(r = R);
    }
    translate([0, 0, R])
    linear_extrude(height = 6 - 2*R)
    difference() {
        translate([52, 19]) square([1, 0.5]);     // 镜像端：弧 (53,19)→(52.5,19.5)，盖到 X=52
        translate([53, 19.5]) circle(r = R);
    }

    // ── 钩口 3 个 90° 内角填充（沿 X，两端各内缩 R 以免在圆化端面处凸出）──
    translate([6.5 + R, 19, 0])
    rotate([90, 0, 90])
    linear_extrude(height = 46 - 2*R)
    union() {
        inner_fillet(1.5, 6, 1, -1);   // 钩口左上（横臂下缘×竖臂内缘）
        inner_fillet(12, 6, -1, -1);   // 钩口右上（横臂下缘×断臂内缘）
        inner_fillet(12, 0, -1, 1);    // 断臂内缘×回钩节顶
    }
}
