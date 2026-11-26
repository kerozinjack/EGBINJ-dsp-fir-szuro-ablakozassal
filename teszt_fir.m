% TESZT_FIR A FIR szurotervezes es a frekvenciavalasz ellenorzese, megadott ellenorzo feladatok:
% Pelda bemenet helyesseg
% Szimmetria vizsgalat
% LP+HP=Kronecker
% 3 pontos mozgoatlag teszt
% konvolucio teszt egy szurovel.
clear;
close all;
clc;

maxhiba = 1e-12;

% 1. pelda

[h_lp_t, nh] = fir_ablak('lp', 5, pi/2, 'teglalap');

h_ref = [0 1/pi 0.5 1/pi 0];
nh_ref = -2:2;

if max(abs(h_lp_t - h_ref)) < maxhiba && isequal(nh, nh_ref)
    fprintf('1. teszt: SIKERES\n');
else
    fprintf('1. teszt: SIKERTELEN\n');
end

%2 szimmetrikusak

N = 3;
wc = pi/2;

h_lp_t = fir_ablak('lp', N, wc, 'teglalap'); %alultegla
h_hp_t = fir_ablak('hp', N, wc, 'teglalap'); %felultegla

h_lp_h = fir_ablak('lp', N, wc, 'hamming'); %alulh
h_hp_h = fir_ablak('hp', N, wc, 'hamming'); %felulh

hiba1 = max(abs(h_lp_t - fliplr(h_lp_t)));
hiba2 = max(abs(h_hp_t - fliplr(h_hp_t)));
hiba3 = max(abs(h_lp_h - fliplr(h_lp_h)));
hiba4 = max(abs(h_hp_h - fliplr(h_hp_h)));

if hiba1 < maxhiba && hiba2 < maxhiba && hiba3 < maxhiba && hiba4 < maxhiba
    fprintf('2. teszt: SIKERES\n');
else
    fprintf('2. teszt: SIKERTELEN\n');
end

% 3. LP + HP = kronecker

kronecker = [0 1 0];

hiba1 = max(abs(h_lp_t + h_hp_t - kronecker));
hiba2 = max(abs(h_lp_h + h_hp_h - kronecker));

if hiba1 < maxhiba && hiba2 < maxhiba
    fprintf('3. teszt: SIKERES\n');
else
    fprintf('3. teszt: SIKERTELEN\n');
end

% 4 3pontos
[H, w] = freqvalasz([1 1 1]/3, -1:1, 3);

H_ref = (1 + 2*cos(w))/3;

hiba = max(abs(H - H_ref));

if hiba < maxhiba
    fprintf('4. teszt: SIKERES\n');
else
    fprintf('4. teszt: SIKERTELEN\n');
end

% 5 matkonvidx=conv szurovel rovid tesztjellel

x = [1 2 -1];
nx = [-1 0 1];

y = matkonv_idx(x, nx, h_lp_t, nx);
y_ref = conv(x, h_lp_t);
hiba = max(abs(y - y_ref));

if hiba < maxhiba
    fprintf('5. teszt: SIKERES\n');
else
    fprintf('5. teszt: SIKERTELEN\n');
end