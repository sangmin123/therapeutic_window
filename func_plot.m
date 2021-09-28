
function func_plot(normal, cancer,xname, tname,per)

if(normal(1)~=0 && normal(1)<0.8)
    normal=1-((1-normal)./(1-normal(1)));
    normal(normal<0)=0;
    plot(per, normal,'-b*')
else
    plot(per, normal,'-b*')
end

hold on; plot(per,per,'--','Color',[0.5 0.5 0.5]);
if(cancer(1)~=0 && cancer(1)<0.8)
    cancer=1-((1-cancer)./(1-cancer(1)));
    cancer(cancer<0)=0;
    plot(per, cancer,'-r*')
else
    plot(per, cancer,'-r*')
end

hold off;
xlabel('drug activity')
ylabel(xname); ylim([0 1])
title(tname)
end