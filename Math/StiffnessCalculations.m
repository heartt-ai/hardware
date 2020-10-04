%First we define the unknown variables for our calculations
syms m F0 B w 

%we then define the internal depth(h) and internal radius of the lid(r)
h=10*10^(-3)%m
r=32*10^(-3)%m

%if we assume the air is 25 deg C, the following will be true:
p = 1.1839	%kg/m^3 (density of air @25deg C)
c = 346.13	%m/s (speed of sound in air @ 25deg C)

%now, we calculate the contact area and and volume of any given cylinder
%using the following equations
A = 3.1415*r^2 %contact area (m^2)
V = A*h %volume of air in stethoscope (m^3)

%From "NUSSBAUMER, Maximilian et al. “A theory for stethoscope acoustics.”
%(2019)."
%The equivilant stiffness of a simple stethoscope system such as ours can be modeled using
k=p*c*A^2/V

%we plug in and solve for the natural frequency, w0, using the equation 
%w0 = sqrt(k/m)
%however, we can normalize the amplitude x to the mass as the ocilating mass will
%not change signifigantly from stethoscope to stethoscope
w0 = sqrt(k)

%Now, using the equation for the displacment responce for a driven, damped
%mass-spring system. 
%Where x is the amplitude of displacement
%F0 is the forcing function
%m is the total mass attached to the ocilating system
%and B is the damping rate 
x = (F0/m)/(sqrt((w^2-w0^2)^2+(2*B*w)^2));
x= simplify(x,1)

%Next, we again, normalize x about m since it does not change from design
%to design
x = x*m

%Next since the forcing frequency (F0, which is the heart beat)is not
%affected by the stethoscope, we can remove it by dividing x by F0
x = x/F0

%Now, we assume the system is only moderately dampened by the friction of the bag,
%the plastic membrane, and air resistance and aproximate the damping ratio (B) to be
%0.8
x = subs(x,B,0.8)

%we establish that is graphed in the frequency range f=0hz to f=1000hz
f = 0:0.5:1000;

%we then replace our frequency w with f
x = subs(x,w,f)

%finaly, now we can plot the aproximate frequency responce graph by plotting the
%normalized amplitude(x) about the frequency f
plot(f,x)






