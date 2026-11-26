% FREQVALASZ A szuro komplex frekvenciavalaszanak kiszamitasa.
% Bemenet: 
% h - szuroegyutthatok
% nh - idoindextartomany (-M:M)
% K - frekvenciapontok szama
% Kimenet: 
% H - komplex frekvenciavalasz
% w - korfrekvenciak (oszlopvektorok).
function [H, w] = freqvalasz(h, nh, K)
    %DTFT keplete:
    % H(omega) = SUM(n=-M:M) [h[n] * e^(-j*omega*n)]
    %pelda:
    % h = [1 1 1] / 3;
    %nh = [-1 0 1];
    %K = 3;

    % frekvenciapontok 0 és pi kozott oszlopvektorba
    w = linspace(0, pi, K).'; % w:[0 pi/2 pi] oszlopba
    
   
    % A korfrekvenciak es idoindexek szorzatainak matrixa
    WN = w * nh;
    %      [0                                   [0      0   0
    % wn=   pi/2 x [ -1 0 1] matrixszorzas =>   -pi/2   0   pi/2    
    %       pi  ]                               -pi     0   pi ] KxN
    
    % komplex ertekek
    % e^(-j*omega*n)
    %     [ 1  1   1
    % E =   j  1  -j
    %      -1  1  -1 ]KxN

    E = exp(-1j * WN);
    

    %szuroegyutthatok oszlopvektorra 
    h = h.';
    
    % frekvenciavalasz, szumma=matrixszorzas
    %H =e^(-j*omega*n) * h
    H = E * h;
end
