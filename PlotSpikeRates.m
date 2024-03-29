function PlotSpikeRates(stimfreq, other, RateIn, RateOut, VectorStrengthIn, VectorStrengthStim, primaryLoopStr, slavePrimaryLoopStr, lDen, stimVS, secondaryLoopStr, secondaryLoopVal)

YLimit = 750;
nominal = 350;
stimfreqMin = min(stimfreq);
stimfreqMax = max(stimfreq);
lDenMin = min(lDen);
lDenMax = max(lDen);
YLimitLine = YLimit*.99*ones(size(stimfreq));
if ~isempty(secondaryLoopStr)
  secondaryPrint = [num2str(secondaryLoopVal),' = ',secondaryLoopStr];
else
  secondaryPrint = '';
end
% curveNom =  line(stimfreq,nominal*ones(size(stimfreq)),...
% 	'color', 'm', 'linestyle', ':');
curveRateIn = line(stimfreq,min(RateIn,YLimitLine),...
	'color', 'b', 'linestyle', '-', 'lineWidth', 2);
curveRateOut = line(stimfreq,min(RateOut,YLimitLine),...
	'color', 'c', 'linestyle', '-', 'lineWidth', 2);
stimfreqAxis = gca;
stimfreqPos = get(stimfreqAxis,'Position');
if (stimfreqPos(4) > 0.5)|(stimfreqPos(2) < 0.2)
	set(stimfreqAxis,'XLabel', text(0,0,primaryLoopStr,'FontSize',12))
end
if (stimfreqPos(4) > 0.5)|((stimfreqPos(2) > 0.2)& ...
	  (stimfreqPos(4)+stimfreqPos(2) < 0.8))
	set(stimfreqAxis,'YLabel', text(0,0,'rate (sp/s)','FontSize',12))
end
set(stimfreqAxis,'XLim', [stimfreqMin stimfreqMax], ...
	'XScale', 'log', ...
	'YAxisLocation', 'left', ...
	'XTick', [500 1000 2000 4000], ...
	'YLim', [0 YLimit], ...
	'YTick', [0 250 500], ...
	'FontSize', 12);
%	'YTick', [0 250 nominal 500 750], ...
%	'YTickLabel', '0|250|nom|500|750', ...
%	'XTick', [250 500 1000 2000 4000], ...
lDenAxis = axes('Position', stimfreqPos);
if (stimfreqPos(4) > 0.5)|(stimfreqPos(4)+stimfreqPos(2) > 0.8)
	set(lDenAxis,'XLabel', text(0,0,'lDen','FontSize',12))
end
set(lDenAxis, 'XAxisLocation','top', ...
	'YAxisLocation', 'right', ...
	'Color', 'none', ...
	'XScale', 'log', ...
	'XDir', 'reverse', ...
	'XLim', [lDenMin lDenMax], ...
	'XTick', [50 100 200 400], ...
	'YLim', [0 YLimit], ...
	'YTick', [], ...
	'FontSize', 12);
%	'XTick', [20 40 80 160 360], ...
ratioAxis = axes('Position', stimfreqPos, ...
	'XAxisLocation','top', ...
	'YAxisLocation', 'right', ...
	'Color', 'none', ...
	'XLim', [stimfreqMin stimfreqMax], ...
	'XTick', [], ...
	'YLim', [0 1.02], ...
	'YTick', [0 0.5 1], ...
	'YTickLabel', ['0|',secondaryPrint,'|1'], ...
	'FontSize', 12);
RateInFix = max(RateIn, 0.0001*ones(size(RateIn)));
%RateOutFix = max(RateOut, 0.0001*ones(size(RateOut)));
%Log10RateInOverOut = log10(RateInFix./RateOutFix);
%curveRateRatio100 = line(stimfreq,Log10RateInOverOut,...
%	'color', 'y', 'linestyle', '-');
Discrim = 1 - RateOut./RateInFix;
curveDisc = line(stimfreq,Discrim,...
	'color', 'r', 'linestyle', '-', 'lineWidth', 3);

% curve1 =  line(stimfreq,1*ones(1,length(stimfreq)),...
% 	'color', [.4 .4 .4], 'linestyle', ':');
curveVectorStrengthIn = line(stimfreq,VectorStrengthIn/100, ...
	'color', [.3 .3 .3], 'linestyle', '-');
curveVectorStrengthStim = line(stimfreq,VectorStrengthStim/100, ...
	'color', [.3 .3 .3]', 'linestyle', '-.');
if (stimfreqPos(4) > 0.34)|((stimfreqPos(2) > 0.2)&...
	  (stimfreqPos(4)+stimfreqPos(2) < 0.8))
	legleft = max(stimfreq)*(1.01);
	ti=text(legleft, 1.75/2, '- in-rate ','color','b','FontSize',9);
	to=text(legleft, 1.55/2, '- out-rate ','color','c','FontSize',9);
	td=text(legleft, 1.35/2, '- discrim ','color','r','FontSize',9);
	%tt=text(legleft, 0.75, '- log ratio ','color','y','FontSize',9);
	tv=text(legleft, 0.50/2, '- VS ','color',[.3 .3 .3],'FontSize',9);
	tw=text(legleft, 0.25/2, '..VS Stim ','color',[.3 .3 .3],'FontSize',9);
end
