$fn = 12;

module sensor() {
    pcb_size = [35.5, 48, 1.5];
    radio_size = [15.2, 29.2, 1.5];
    distance = 15.3;
    radio_offset = [pcb_size[0] - radio_size[0] / 2 - 6.1, pcb_size[1] - 17, distance + pcb_size[2]];
    radio_conn_offset = [pcb_size[0] - 6.2, pcb_size[1] - 14.2, pcb_size[2]];
    battery_offset = [pcb_size[0] / 2, 17.5, pcb_size[2]];
    capacitor_offset = [pcb_size[0]/2, pcb_size[1] - 12.5, pcb_size[2]];
    mc_offset = [6.1, pcb_size[1] - 7.7, pcb_size[2]];
    sensor_offset = [pcb_size[0] - 4.7, pcb_size[1] - 8.6, pcb_size[2]];
    sensor_conn_offset = [6.7, pcb_size[1] - 14.8, pcb_size[2]];
    jumper_offset = [pcb_size[0] / 2, pcb_size[1] - 5, pcb_size[2]];

    module mainboard(size=pcb_size)
    {
        difference() {
            union() {
                // pcb
                cube(size);
                // component space
                %translate([0, 0, pcb_size[2]])
                cube(size+[0,0,distance-pcb_size[2]]);
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

    module radio_conn() {
        size = [10.4, 5.1, distance];
        translate([0, 0, size[2]/2]) cube(size, center=true);
    }

    module sensor_conn() {
        size = [10.4, 2.4, distance];
        translate([0, 0, size[2]/2]) cube(size, center=true);
    }

    module battery_cr2477() {
        battery_size = [25.5, 12.4];
        cylinder(h=battery_size[1], r=battery_size[0]/2);
        translate([0, (4.4-battery_size[0])/2-3, battery_size[1] / 2])
        cube([10.7, 4.4, battery_size[1]], center=true);
    }

    module capacitor() {
        size = [8.1, 13];
        cylinder(h=size[1], r=size[0]/2);
    }

    module mc() {
        size = [10, 10, 8];
        translate([0, 0, size[2]/2]) cube(size, center=true);
    }

    module sensor() {
        size = [3, 3, 1];
        translate([0, 0, size[2]/2]) cube(size, center=true);
    }

    module jumper() {
        size = [5.5, 5.5, 8];
        translate([0, 0, size[2]/2]) cube(size, center=true);
    }

    mainboard();
    translate(radio_offset) radio();
    translate(radio_conn_offset) radio_conn();
    translate(battery_offset) battery_cr2477();
    translate(capacitor_offset) capacitor();
    translate(mc_offset) mc();
    translate(sensor_offset) sensor();
    translate(sensor_conn_offset) sensor_conn();
    translate(jumper_offset) jumper();
}
