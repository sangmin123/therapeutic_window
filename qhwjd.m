function normal=qhwjd(normal)
if(normal(1)~=0 && normal(1)<0.8)
    normal=1-((1-normal)./(1-normal(1)));
    normal(normal<0)=0;
%     plot(per, normal,'-b*')
end
end