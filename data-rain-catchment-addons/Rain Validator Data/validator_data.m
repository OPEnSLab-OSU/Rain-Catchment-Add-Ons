clf;
clear;
clc;

%minutes since first data point
t1 = [0,1509,4389,8741,13002,18822];
t2 = [0,2884,10093,11605,12998,20092,21571];

%validator mass in trial 1 and 2
val1 = [368.93, 350.99, 322.27, 284.75, 249.56, 213.03];
val2 = [443.87, 410.33, 274.81, 242.48, 216.64, 191.88, 191.86];

beaker1 = [1327.87, 1311.8, 1280.85, 1241.44, 1197.76, 1148.98];
beaker2 = [1297.65, 1268.54, 1119.46, 1078.79, 1043.47, 894.3, 863.86];


subplot(2,2,1);
plot(t1, val1, 'b','LineWidth',2);
hold on;
plot(t1,beaker1,'r','LineWidth',2);
hold on;
title('Trial 1 mass');
xlabel('minutes');
ylabel('kg');
legend('validator','beaker');
legend('location','southeast');
legend('boxoff');

subplot(2,2,3);
plot(t2, val2, 'b','LineWidth',2);
hold on;
plot(t2, beaker2, 'r','LineWidth',2);
hold on;
title('Trial 2 mass');
xlabel('minutes');
ylabel('kg');



beaker1b = zeros(1,length(beaker1));
val1b = zeros(1,length(val1));
beaker2b = zeros(1,length(beaker2));
val2b = zeros(1:length(val2));

beaker1b = beaker1 / beaker1(1) * 100;
val1b = val1 / val1(1) * 100;
beaker2b = beaker2 / beaker2(1) * 100;
val2b = val2 / val2(1) * 100;


subplot(2,2,2);

plot(t1,val1b,'b','LineWidth',2);
hold on;
plot(t1,beaker1b, 'r','LineWidth',2);
hold on;
title('Trial 1 percent of initial');

subplot(2,2,4);

plot(t2,val2b,'b','LineWidth',2);
hold on;
plot(t2,beaker2b,'r','LineWidth',2);
hold on;
title('Trial 2 percent of initial');

figure();

val1c = -(val1(1:end-1) - val1(2:end)) ./ (t1(1:end-1) - t1(2:end))*1000;
val2c = -(val2(1:end-1) - val2(2:end)) ./ (t2(1:end-1) - t2(2:end))*1000;
beaker1c = -(beaker1(1:end-1) - beaker1(2:end)) ./ (t1(1:end-1) - t1(2:end))*1000;
beaker2c = -(beaker2(1:end-1) - beaker2(2:end)) ./ (t2(1:end-1) - t2(2:end)) *1000;
subplot(2,1,1);
plot(t1(2:end),val1c,'b');
hold on;
plot(t1(2:end),beaker1c,'r');
xlabel('minutes');
ylabel('mg / min');
title('Trial 1 evaporation rate vs time');

subplot(2,1,2);
plot(t2(2:end),val2c,'b');
hold on;
plot(t2(2:end),beaker2c,'r');
xlabel('minutes');
ylabel('mg/min');
title('Trial 2 evaporation rate vs time');

val1d = val1 - 192.49;
val2d = val2 - 192.49;

val1_beaker = beaker1 ./ val1;
val2_beaker = beaker2 ./ val2;

figure();
subplot(2,1,1);
plot(val1d,val1_beaker,'r');
title('Trial 1 Validator/beaker vs validator water');
xlabel('Validator Water Mass');
subplot(2,1,2);
plot(val2d,val2_beaker,'r');
title('Trial 2 Validator/beaker vs validator water');
xlabel('Validator Water Mass');

