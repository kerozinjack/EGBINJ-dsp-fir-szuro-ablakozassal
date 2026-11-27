% SZURES_DEMO A tervezett FIR szurok mukodesenek bemutatasa.
% Frekvenciavalasz, jelszures es a kauzalis szuro kesleltetese.

clear;
close all;
clc;

% 1. Tesztjel 

nx = 0:199;

x = cos(0.1*pi*nx) + 0.5*cos(0.6*pi*nx);

alacsonytartva = cos(0.1*pi*nx);

% 2. Alulatereszto szurok

N = 31;
wc = pi/3;
M = (N-1)/2;

[h_t, nh_t] = fir_ablak('lp', N, wc, 'teglalap');
[h_h, nh_h] = fir_ablak('lp', N, wc, 'hamming');

% 3. frekvenciavalasz abrazolasa

K = 1000;

[H_t, w] = freqvalasz(h_t, nh_t, K);
H_h = freqvalasz(h_h, nh_h, K);

% amplitudo->decibel
H_t_db = 20*log10(abs(H_t));
H_h_db = 20*log10(abs(H_h));

figure(1);

plot(w, H_t_db);
hold on;
plot(w, H_h_db);

xline(wc, '-', 'wc');
xline(0.1*pi, '-', '0.1pi');
xline(0.6*pi, '-', '0.6pi');

xlim([0 pi]);
ylim([-80 5]);

title('A szurok frekvenciavalasza');
xlabel('Korfrekvencia [rad/minta]');
ylabel('Amplitudo [dB]');
legend('Teglalap', 'Hamming');
grid on;

hold off;

% 4. szures hammingszurovel

[y, ny] = matkonv_idx(x, nx, h_h, nh_h);

% 5. Idotartomanybeli abrazolas

figure(2);

subplot(3, 1, 1);
plot(nx, x);
title('Bemeneti jel');
xlabel('n');
ylabel('x[n]');
grid on;

subplot(3, 1, 2);
plot(ny, y);
title('Szurt jel');
xlabel('n');
ylabel('y[n]');
grid on;

subplot(3, 1, 3);
plot(nx, alacsonytartva);
title('Vart kimenet');
xlabel('n');
ylabel('xref[n]');
grid on;

% 6. Kauzalis szuro

% A szuro idoindexeinek eltolasa M mintaval
nh_kauz = nh_h + M;

[y_kauz, ny_kauz] = matkonv_idx(x, nx, h_h, nh_kauz);

figure(3);

plot(ny, y);
hold on;
plot(ny_kauz, y_kauz);

title('Eredeti es eltolt kimenet');
xlabel('n');
ylabel('y[n]');
legend('Nem kauzalis', 'Kauzalis');
grid on;

hold off;