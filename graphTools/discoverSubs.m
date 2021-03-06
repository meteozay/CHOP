%> Name: discoverSubs
%>
%> Description: This function discovers parts and their realizations with
%> graphs defined by vocabLevel and graphLevel, as well as their printed
%> versions in graphFileName. 
%>
%> @param vocabLevel If preDefinedSearch is 1, the compositions in this
%> vocabulary level are searched in graphLevel. If 0, simply ignored.
%> @param redundantVocabLevel If preDefinedSearch is 1, the compositions in this
%> redundant vocabulary level are searched in graphLevel. If 0, simply ignored.
%> @param graphLevel The current object graphs' level.
%> @param options Program options.
%> @param currentFolder Path to the workspace folder.
%> @param preDefinedSearch If true, supervised search is run. 
%> If empty, unsupervised SUBDUE runs over graphLevel.
%> @param levelItr current level id.
%>
%> @retval vocabLevel If preDefinedSearch is 1, [] is returned. If it is 0,
%> best compositions discovered are returned.
%> @retval graphLevel The graph consisting of part realizations discovered.
%> It's just a dummy graph including realization labels and children.
%> 
%> Author: Rusen
%>
%> Updates
%> Ver 1.0 on 15.01.2014
%> 'self' type search added on 05.02.2014
function [vocabLevel, graphLevel, prevGraphData] = discoverSubs( vocabLevel, redundantVocabLevel, graphLevel, options, preDefinedSearch, levelItr)
    startTime = tic;
    prevGraphData = [];
    if ~preDefinedSearch
        display(['.... Discovering compositions in level ' num2str(levelItr) '.']); 
    end
    
    % Search for substructures.
    if preDefinedSearch
        % Inference on the test image with learned vocabularies.
        % This part is again related to combining parts. 
        % The status of this section is debatable. Please wait for updates.
        % It'll be unhid as soon as possible.
        graphLevel = inferSubs(vocabLevel, redundantVocabLevel, graphLevel, options);
    else
        [vocabLevel, graphLevel, prevGraphData] = runSubdue(vocabLevel, graphLevel, options);
    end
    
    % Show time elapsed.
    display(['.... Time elapsed: ' num2str(toc(startTime)) ' secs.']);
    display(['.... Found ' ...
        num2str(numel(graphLevel)) ' instances of ' num2str(numel(vocabLevel)) ' compositions.']);
end
