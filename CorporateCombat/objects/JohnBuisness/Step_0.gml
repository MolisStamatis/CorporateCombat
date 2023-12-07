// @description Movement Handler
rightKey = keyboard_check(vk_right) - keyboard_check(vk_left) + keyboard_check(ord("D")) - keyboard_check(ord("A"));
upKey = keyboard_check(vk_up) - keyboard_check(vk_down) + keyboard_check(ord("W")) - keyboard_check(ord("S"));

// Determine horizontal and vertical speeds
X_Speed = rightKey * Speed;
Y_Speed = -upKey * Speed;

// Normalize diagonal movement
if (X_Speed != 0 && Y_Speed != 0) {
    var diagonalSpeed = Speed / sqrt(2);
    X_Speed = sign(X_Speed) * diagonalSpeed;
    Y_Speed = sign(Y_Speed) * diagonalSpeed;
}

// Update position
x += X_Speed;
y += Y_Speed;