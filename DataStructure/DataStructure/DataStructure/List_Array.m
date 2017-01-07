//
//  List_Array.m
//  test
//
//  Created by 夯大力 on 17/1/4.
//  Copyright © 2017年 Handyzzz. All rights reserved.
//




#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>

//结构名和结构指针的区别

typedef int ListItem;
//typedef struct alist *List;可以写在下边一起
typedef struct alist{
    int n;
    int maxsize;
    ListItem* table;//表示元素数组
}Alist,*List;

//声明函数
//表结构初始化函数
List ListInit(int);
//测试表L是否为空
int ListEmpty(List);
//元素x在表L中的位置
int ListLocate(int,List);
//表L的位置k处的元素
ListItem ListRetrieve(int,List);
//表元素插入运算ListInsert(k,x,L)
void ListInsert(int,int,List);
//表元素删除元素运算ListDelete(k,L)
ListItem ListDelete(int, List);
//PrintList(L)运算
void PrintList(List);
void Error(char*);
void ItemShow(int);


int main(){
    //表结构初始化函数
    List L = ListInit(100);
    //测试表L是否为空
    printf("表是否为空：%d\n",ListEmpty(L));
    PrintList(L);
    //表元素插入运算ListInsert(k,x,L)
    ListInsert(0,111,L);
    PrintList(L);
    //元素x在表L中的位置
    printf("%d\n",ListLocate(0,L));
    //表L的位置k处的元素（生活位置起点）
    printf("%d\n",ListRetrieve(1,L));
    //表元素删除元素运算ListDelete(k,L)（生活位置起点）
    printf("%d\n",ListDelete(1, L));
    //PrintList(L)运算
    PrintList(L);
    
    return 0;
}

//定义函数
//表结构初始化函数
List ListInit(int size){
    List L = malloc(sizeof*L);
    L->table = malloc(size *sizeof(ListItem));
    L->maxsize = size;
    L->n = 0;
    return L;
}
//测试表L是否为空
int ListEmpty(List L){
    return L->n == 0;
}
int ListLength(List L){
    return L->n;
}
//表运算ListLocate(x,L)和ListRetrieve(k,L)也很容易实现
//元素x在表L中的位置
int ListLocate(ListItem x,List L){
    int i;
    for(i = 0; i<L->n; i++)
        if(L->table[i] == x) return ++i;
    return 0;
}
//表L的位置k处的元素
ListItem ListRetrieve(int k,List L){
    if(k < 1 || k > L->n ) {
        Error("out of bounds");
    }
    return L->table[k-1];
}
//表元素插入运算ListInsert(k,x,L)
void ListInsert(int k,ListItem x,List L){
    int i;
    if(k < 0 || k >L->n) {
        Error("out of bounds");
    }
    if(L->n == L->maxsize){
        Error("out of memory");
    }
    for(i = L->n-1; i>=k; i--) L->table[i+1] = L->table[i];
    L->table[k] = x;
    L->n++;
}
//表元素删除元素运算ListDelete(k,L)
ListItem ListDelete(int k, List L){
    int i;
    ListItem x;
    if(k < 1 || k > L->n){
        Error("out of bounds");
    }
    x = L->table[k-1];
    for(i = k; i<L->n; i++) L->table[i-1] = L->table[i];
    L->n--;
    return x;
}
//PrintList(L)运算
void PrintList(List L){
    if(L->n==0)
        printf("表是空的\n");
    int i;
    for(i = 0; i < L->n; i++) ItemShow(L->table[i]);
}

void Error(char*argv){
    printf("%s\n",argv);
    exit(1);
}
void ItemShow(int x){
    printf("此时表中全部元素是：%d\n",x);
}


