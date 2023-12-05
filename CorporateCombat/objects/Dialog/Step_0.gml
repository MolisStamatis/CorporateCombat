if (keyboard_check_pressed(vk_space)) {
	NPCtest.dialogIndex += 1;

    if (NPCtest.dialogIndex >= array_length_1d(NPCtest.dialogLines)) {
        instance_destroy();
    }
}