clear;
close all;
load('Data1.mat');

[T,Ages] = size(P.Employed);
lag = 0;
Employed2 = zeros(T-lag,Ages);
one = ones(T-lag,1);
x = [one, P.gdp(1:end-lag)];
STAT = zeros(2,Ages);

for i = 1:Ages
    [b,~,r,~,stat] = regress(P.Employed(1+lag:end,i),x);
    STAT(:,i) = [stat(1);stat(3)];  % R2, F-pValue
    Employed2(:,i) = r+b(1);
end

[b,~,r,~,stat] = regress(P.employed(1+lag:end,:),x);
employed2 = r+b(1);

per = 41:113;
per = per(1+lag:end);
plot(P.Time(per),Employed2);
legend('20-24','25-34','35-44','45-54','55-64','65+','location','se');
title('DeGDPed Employed-Pop Ratio','Fontsize',12);
ylabel('%');
figure;

plot(P.Time(per),P.Employed(1+lag:end,:));
legend('20-24','25-34','35-44','45-54','55-64','65+','location','se');
title('Employed-Pop Ratio','Fontsize',12);
ylabel('%');

% P.Employed2 = Employed2;
% P.employed2 = employed2;
