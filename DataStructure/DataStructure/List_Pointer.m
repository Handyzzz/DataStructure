//
//  List_Pointer.m
//  DataStructure
//
//  Created by 夯大力 on 17/1/4.
//  Copyright © 2017年 Handyzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <stdio.h>
#include <stdlib.h>
typedef int ListItem;
typedef struct node *Link;
typedef struct node
{
    //存放的数据
    ListItem element;
    //指向下个节点的指针
    Link next;//Link 相当于struct node * 或者以后的Node*
}Node;

typedef struct plist*List;
typedef struct plist{
    Link first;
}Plist;


//声明函数
void Error(char*);
Link NewNode();
List ListInit();
int ListEmpty(List);
int ListLength(List);
ListItem ListRetrieve(int,List);
int ListLocate(ListItem,List);
void ListInsert(int,ListItem,List);
ListItem ListDelegate(int,List);
void ItemShow(int);

int main(){
    //创建一个空表
    List list = ListInit();
    //测试表是否为空
    ListEmpty(list);
    //计算表的长度
    ListLength(list);
    //表中插入元素
    
    return 0;
}


//创建一个空表
List ListInit(){
    List L = malloc(sizeof(L));
    L->first = 0;
    return L;
}

//创建一个新接点
Link NewNode(){
    Link p;
    if((p=malloc(sizeof(Node)))==0)
        Error("Exhausted memory");
    else return p;
    return p;
}
//判断当前表是否为空
int ListEmpty(List L){
    return L->first == 0;
}
//计算表的长度
int ListLength(List L){
    int len = 0;
    Link p;
    p = L->first;
    while (p) {
        len++;
        p = p->next;
    }
    return len;
}
//找出L表中的第k个元素
ListItem ListRetrieve(int k,List L){
    int i;
    Link p;
    if (k < 1) {
        Error("out of bounds");
    }
    p = L->first;
    i = 1;
    while (i < k && p) {
        p = p->next;
        i++;
    }
    return p->element;
}
//找出x元素在表中的位置
int ListLocate(ListItem x,List L){
    int i = 1;
    Link p;
    p = L->first;
    while (p && p->element != x) {
        p = p->next;
        i++;
    }
     return p ? i:0;
}
//在表中插入元素
void ListInsert(int k,ListItem x,List L){
    Link p,y;
    int i;
    if (k < 0) {
        Error("out of bounds");
    }
    p = L->first;
    for (i = 1; i < k && p; i++) {
        p = p->next;
    }
    y = NewNode();
    y->element = x;
    if (k) {
        y->next = p->next;
        p->next = y;
    }else{
        y->next = L->first;//在位置p处插入
        L->first = y;//在表首处插入
    }
}

//在表中删除元素
ListItem ListDelegate(int k ,List L){
    Link p,q;
    ListItem x;
    int i;
    if (k < 1 || !L->first) {
        Error("out of bounds");
    }
    p = L->first;
    if (k == 1) {
        L->first = p->next;//删除表首元素
    }else{
        q = L->first;//找到第k-1个元素所在结点q
        for (i = 1; i < k-1 && 1; i++) {
            q = q->next;
        }
        p = q->next;//第k个元素所在结点p
        q->next = p->next;//删除结点p

    }
    x = p->element;//保存第k个元素并释放结点p
    free(p);
    return x;
}
//输出表
void PrintList(List L){
    Link p;
    for (p = L->first; p; p = p->next) {
        ItemShow(p->element);
    }
}
void Error(char*a){
    printf("%s\n",a);
    //退出进程
    exit(1);
}
void ItemShow(int x){
    printf("此时表中全部元素是：%d\n",x);
}


