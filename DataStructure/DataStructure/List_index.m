//
//  List_index.m
//  DataStructure
//
//  Created by 夯大力 on 17/1/6.
//  Copyright © 2017年 Handyzzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>

typedef int ListItem;
typedef struct snode *Link;
typedef struct snode{
    ListItem element;
    int next;
}Snode;

/*
typedef struct space *Space;
typedef struct space{
    int num,first;
    Link node;
}Simul;
 */


typedef struct dspace *Space;
typedef struct dspace{
    int num,first1,first2;
    Link node;
}Dspace;


typedef struct slist *List;
typedef struct slist{
    int first;
    Space s;
}Slist;

/*
//创建初始数组可用空间
Space SpaceInit(int max){
    int i;
    Space s = malloc(sizeof(*s));
    s->num = max;
    s->node = malloc(max*(sizeof(*s->node)));
    for (i = 0; i < max-1; i++) {
        s->node[i].next = i+1;
    }
    s->node[max-1].next = -1;
    s->first = 0;
    return s;
}
 */

/*
//从当期可用数组空间 分配一个数组单元函数
int SpaceAlloc(Space s){
    int i;
    i = s->first;
    s->first = s->node[i].next;
    return i;
}
 */

/*
//释放s的数组单元i的函数SpaceDeallocate(i,s)实现如下；
void SpaceDeallocate(int i,Space s){
    s->node[i].next = s->first;
    s->first = i;
}
 */

//创建初始数组可用空间
Space SpaceInit(int max){
    Space s = malloc(sizeof(s));
    s->num = max;
    s->node = malloc(max*(sizeof(*s->node)));
    s->first1 = 0;
    s->first2 = -1;
    return s;
}

//从当期可用数组空间 分配一个数组单元函数
int SpaceAllocate(Space s){
    int i;
    if (s->first2 == -1) {
        return s->first1++;
    }
    i = s->first2;
    s->first2 = s->node[i].next;
    return i;
}


//释放s的数组单元i的函数SpaceDeallocate(i,s)实现如下；
void SpaceDealocate(int i,Space s){
    s->node[i].next = s->first2;
    s->first2 = i;
}


void Error(char*argv){
    printf("%s\n",argv);
    exit(1);
}
void ItemShow(int x){
    printf("此时表中全部元素是：%d\n",x);
}



//创建一个空表
List ListInit(int size){
    List L = malloc(sizeof(*L));
    L->s = SpaceInit(size);
    L->first = -1;
    return L;
}

//计算标的长度
int ListLength(List L){
    int i,len;
    i = L->first;   //当前表接点游标
    len = 0;
    while (i != -1){
        len++;
        i = L->s->node[i].next;
    }
    return len;
           
}

//搜索表中的第k个元素
ListItem ListRetrieve(int k,List L){
    int p,i = 1;
    if (k < 1) {
        Error("out of boudns");
    }
    p = L->first;
    while (i <k && p != -1) {
        p = L->s->node[i].next;
        i++;
    }
    return L->s->node[p].element;
}

//表中x元素在表中的位置
int ListLcote(ListItem x,List L){
    int p,i = 1;
    p = L->first;
    while (p != -1 && L->s->node[p].element != x) {
        p = L->s->node[p].next;
        i++;
    }
    return (p >= 0 ? i:0);
    
}

//插入元素
void ListInsert(int k,ListItem x,List L){
    int p,y,i;
    if (k < 0) {
        Error("out of bounds");
    }
    p = L->first;
    for (i = 1; i < k && p != -1;i++ ) {
        p = L->s->node[p].next;
    }
    y = SpaceAllocate(L->s);
    L->s->node[y].element = x;
    /*请将结点插入表的第k个结点之后*/
    if (k) {
        L->s->node[y].next = L->s->node[p].next;
        L->s->node[p].next = y;
    }else{
        L->s->node[y].next = L->first;
        L->first = y;
    }
}
//表中删除元素
ListItem ListDelete(int k,List L){
    int p,q,i;
    ListItem x;
    if (k < 1 || L->first == -1) {
        Error("out of bounds");
    }
    p = L->first;//搜索游标
    if (k == 1) {
        L->first = L->s->node[p].next;//删除表首元素
    }else{
        p = q;
        for (i =1; i < k-1 && q != -1; i++) {
            q = L->s->node[q].next;
            L->s->node[p].next = L->s->node[p].next;
        }
    }
    x = L->s->node[p].element;
    SpaceDealocate(p, L->s);
    return x;
}
//打印表
void PrintList(List L){
    int p;
    for (p = L->first; p != -1; p = L->s->node[p].next) {
        ItemShow(L->s->node[p].element);
    }
}

int main(void){
    
}

