clear all
close all
x = 0.1: 1/20: 1;

d = (1 + 0.6 * sin (2 * pi * x / 0.7) + 0.3 * sin (2 * pi * x)) / 2;

hold on
plot(x, d, 'x')

c1 = 0.2;
c2 = 0.9;
r1 = 0.18;
r2 = 0.18;


w1 = randn(1);
w2 = randn(1);
b = randn(1);

y = zeros(1,20);
learning_rate = 0.1;

% training
for j=1:100
   for i=1:length(x)
        phi_1 = exp(-(x(i)-c1)^2/(2*r1^2));
        phi_2 = exp(-(x(i)-c2)^2/(2*r2^2));

        y = phi_1*w1 + phi_2*w2 + b;
        e = d(i) - y;

        w1 = w1 + learning_rate * e * phi_1;
        w2 = w2 + learning_rate * e * phi_2;
        b = b + learning_rate * e;
   end
end

% Validation
% In this step we only compute the output

Y = []

for i=1:length(x)
    phi_1 = exp(-(x(i)-c1)^2/(2*r1^2));
    phi_2 = exp(-(x(i)-c2)^2/(2*r2^2));

    y = phi_1*w1 + phi_2*w2 + b;

    Y = [Y y]
end

% Plot results
plot(x, Y, '-');
legend('real data', 'approximation using RBF');
hold off;

% -----------------------
% Papildoma uzduotis
% Apmokykite SBF tinklą kitu algoritmu, kuris taip pat atnaujina/parenka automatiškai
% ir centrų c1, c2 bei spindulių r1, r2 reikšmes.
% 1. surandame centru vietas pagal k-means
new_arr = []; % CHANGE NAME

for i=1:length(x)
    % pakeiciam reiksmes lygtais butu histograma, kad vienas taskas (y)
    % nusako kiek reiksmiu x yra.
    % jei x = 0.1 y = 0.92, tai pakeiciam, kad 0.1 yra 92 irasai.
    val = ones(1,round(d(i)*100)) * x(i); % TODO rename
    new_arr = [new_arr val];
end

% atvaizduojam duomenis
figure(2);
histogram(new_arr, 19);

% surandame grupes ir centrus
[idx,C] = kmeans(new_arr.' ,2); % - 2, nes zinau, kad 2 centrai, bet nezinau kur

% atrenkam taskus i klusterius
cluster_1 = new_arr(idx == 1);
cluster_2 = new_arr(idx == 2);

% pagal standartini nuokrypi randam radius
radius_1 = std(cluster_1);
radius_2 = std(cluster_2);

% TODO: pridek apmokyma ir vaizdavima kaip apsimoko su siais budais.

% TODO rask max jei d(1) < d(2) && d(2) > d(3) kol surandam