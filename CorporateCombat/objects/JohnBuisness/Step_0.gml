if (keyboard_check(vk_space)) {
	NPCtest.dialogIndex += 1;
	if (NPCtest.dialogIndex >= array_length_1d(NPCtest.dialogLines)) {
		NPCtest.dialogIndex = 0;
	}
}