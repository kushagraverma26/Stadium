import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../main.dart';

Future<QueryResult> allMerchandise() async {
  String allMerchandise = '''

      query{
          merchs{
              id
              desc
              name
              price
              images{
                url
              } 
            }
          }

    ''';
  //print(signupMutation);

  print("/*-/*-/*-/*-Trying to get Data/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.query(
    QueryOptions(
      document: allMerchandise,
    ),
  );

  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");

  //print(result.data.data);
  //print(result.errors[0]);
  print(result.data.data);
  // print(result.data.data['tokenAuth']['token']);
  return result;
  /* print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
  if(result.data.error){
    return null;
  }
  if(result.data.data['tokenAuth'] == null){
    return null;
  }
else{
  return(result.data.data['tokenAuth']['token']);}*/
}











Future<QueryResult> buyMerch(String merchId) async {
  String buyMerch = '''

      mutation {
        buyMerch(merchId: $merchId){
            transaction{
              id
              amount
              time
            }
          }
        }
          

    ''';
  print(buyMerch);

  print("/*-/*-/*-/*-Trying to buy game/*-/*-/*-/*-/*-/*-");

  GraphQLClient _client = graphQLConfiguration.clientToQuery();
  QueryResult result = await _client.mutate(
    MutationOptions(
      document: buyMerch,
    ),
  );
  //print(json.decode(result.data.data));
  print(
      "qqqqqqqqqqqq----------------------------------------------qqqqqqqqqqqqqqq");


  return result;
 
}
