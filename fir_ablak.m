% FIR_ABLAK Veges impluzusvalasz szuro tervezese ablakozassal
% Bemenet: 
%   tipus ('lp'/'hp')
%   N (paratlan pozitiv egesz)
%   wc (radian/minta)
%   ablak ('teglalap'/'hamming')
% Kimenet: 
%   h - szuroegyutthatok (N hosszu sorvektor)
%   nh - a hozzajuk tartozo idoindexek
% Pelda: [h, nh] = fir_ablak('lp', 5, pi/2, 'teglalap');

function [h, nh] = fir_ablak(tipus, N, wc, ablak)

    % szurohossz 
    if ~isnumeric(N) || ~isscalar(N) || ~isreal(N) || ~isfinite(N)
        error('N veges valos szam legyen!');
    end
    N = double(N);
    if N <= 0 || N ~= floor(N) || mod(N, 2) == 0
        error('N paratlan pozitiv egesz legyen!');
    end

    % vagasi korfrekvencia
    if ~isnumeric(wc) || ~isscalar(wc) || ~isreal(wc) || ~isfinite(wc)
        error('wc veges valos szam legyen!');
    end
    wc = double(wc);
    if wc <= 0 || wc >= pi
        error('A vagasi korfrekvencia 0 es pi kozott legyen!');
    end

    % szurotipus
    if ~strcmp(tipus, 'lp') && ~strcmp(tipus, 'hp')
        error('Ismeretlen szurotipus!');
    end

    % ablaktipus
    if ~strcmp(ablak, 'teglalap') && ~strcmp(ablak, 'hamming')
        error('Ismeretlen ablaktipus!');
    end

    % idoindexek
    M = (N - 1) / 2;
    nh = -M:M;

    % lp szuroegyutthatok
    h = zeros(1, N);

    for i = 1:N
        n = nh(i);
        if n == 0
            h(i) = wc / pi;
        else
            h(i) = sin(wc * n) / (pi * n);
        end
    end

    % Ablakozas
    for i = 1:N
        n = nh(i);
        
        % hamming
        if strcmp(ablak, 'hamming') && N > 1
            w = (0.54) + (0.46 * cos((2 * pi * n) / (N - 1)));
        %teglalap
        else 
            w = 1;
        end

        h(i) = h(i) * w;
    end

    % hp szuro lp szurobol
    %kronecker: 1 ha n=0, 0 ha n!=0, kronecker-h
    if strcmp(tipus, 'hp')
        for i = 1:N
            if nh(i) == 0
                h(i) = 1 - h(i);
            else
                h(i) = 0 - h(i);
            end
        end
    end
end
