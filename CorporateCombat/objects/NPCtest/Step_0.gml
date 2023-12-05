var distanceToPlayer = point_distance(x, y, JohnBuisness.x, JohnBuisness.y);

if (distanceToPlayer <  50) {
	if (keyboard_check_pressed(vk_space)) {
		instance_create_layer(x, y - 50, "Instances", Dialog);
		Dialog.dialogIndex = 0;
	}
}