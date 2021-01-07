$fn = 12;

module sensor() {
    pcb_size = [38, 45.5, 1.5];
    radio_size = [15.2, 29.2, 1.5];
    distance = 15.3;
    radio_offset = [(pcb_size[0] - radio_size[0]) / 2, pcb_size[1] - 13.5, distance + pcb_size[2]];

    module mainboard(size=pcb_size)
    {
        hole_d = 3.5;
        difference() {
            union() {
                // pcb
                cube(size);
                // component space
                %translate([0, 0, pcb_size[2]])
                cube(size+[0,0,distance-pcb_size[2]]);
            }

            // mount holes
            for (i = [4.5, size[0] - 4.5]) {
                translate([i, 6.3, 0])
                cylinder(h=size[2] + distance, r=hole_d/2);
            }
        }
    }

    module radio(size=radio_size) {
        ant_d1 = 0.7;
        ant_d2 = 4.5;
        ant_length = 30.8;
        ant_leg = 8;

        // pcb
        cube(size);

        // antenna leg
        translate([size[0]/2, size[1] - 5, size[2] + ant_d1/2])
        rotate([-90, 0, 0])
        cylinder(h=ant_leg+5,d=ant_d1);

        // antenna spring
        translate([size[0]/2, size[1] + ant_leg, size[2] + ant_d1/2])
        rotate([-90, 0, 0])
        cylinder(h=ant_length, r=ant_d2/2);
    }

    mainboard();
    translate(radio_offset) radio();
}
