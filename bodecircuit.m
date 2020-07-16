c = tf([1 6],[10 10]);
bode(c)

c = tf([0.001 1],[0.1 1]);
margin(c)

c = tf([1 6],[10 10]);
margin(c)