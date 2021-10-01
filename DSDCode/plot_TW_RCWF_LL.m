load TW_RCWF.mat
for ii = 1:length(TW.shape)
    if (isempty(TW.shape(ii).range))
        continue
    else
        for jj = 1:length(TW.shape(ii).range)
            centerx(jj) = TW.shape(ii).long(jj);
            centery(jj) = TW.shape(ii).lat(jj);
        end
        plot(centerx,centery,'k-','LineWidth',2);
        hold on;
        clear centerx centery;
    end
end
axis image
