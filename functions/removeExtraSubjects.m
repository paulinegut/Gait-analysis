function [newMarkers, subject] = removeExtraSubjects (markers, subject)

    %% Now remove those fucking extra subjects : if the markers have a subject prefix, erase it!
    test = fieldnames(markers);
    
    % if ANY of the subjects are found in the markers definition
    for i = 1:length(test)
        if regexp(test{i}, subject) == 1
            newMarkers.(test{i}(length(subject)+1:end)) = markers.(test{i});
        else
            newMarkers.(test{i}) = markers.(test{i});
        end
    end
    