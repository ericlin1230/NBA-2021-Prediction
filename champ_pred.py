import pandas as pd
from sklearn.tree import DecisionTreeClassifier # Import Decision Tree Classifier
from sklearn.model_selection import train_test_split # Import train_test_split function
from sklearn import metrics #Import scikit-learn metrics module for accuracy calculation

team = pd.read_csv("nba_champs_train.csv", header=0)

team2 = pd.read_csv("sea21.csv", header=0)

total_team = [0] * 30
total_acc = 0
for ii in range(1000):
    feature_cols = ['fg_percent','x3p_percent','ft_percent','ast','tov','wpct']
    X = team[feature_cols]
    champ = team.champs
    X_train, X_test, y_train, y_test = train_test_split(X, champ, test_size=0.3, random_state=1)
    clf = DecisionTreeClassifier(criterion="gini", max_depth=7)
    clf = clf.fit(X_train,y_train)
    y_pred = clf.predict(X_test)
    total_acc += metrics.accuracy_score(y_test, y_pred)
    #print("Accuracy:",metrics.accuracy_score(y_test, y_pred))

    X2 = team2[feature_cols]
    y_pred2 = clf.predict(X2)
    #print(y_pred2)
    indx = 0
    for i in range(len(y_pred2)):
        if y_pred2[i]==1:
            indx = i
            #print(i)
            total_team[indx]+=1
            break

max_value = max(total_team)
max_index = total_team.index(max_value)
print("Average Accuracy:",total_acc/1000)
print(team2.at[max_index,'team'])
print(max_value)

# from sklearn.tree import export_graphviz
# from six import StringIO
# from IPython.display import Image
# import pydotplus
# dot_data = StringIO()
# export_graphviz(clf, out_file=dot_data,
#                 filled=True, rounded=True,
#                 special_characters=True,feature_names = feature_cols,class_names=['0','1'])
# graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
# graph.write_png('diabetes.png')
# Image(graph.create_png())
