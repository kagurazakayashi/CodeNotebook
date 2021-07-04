#include <stdio.h>
#define max 20
int visited[max];
int w;
typedef struct arcnode {
    int adjvex;              //该弧指向的顶点的位置
    struct arcnode *nextarc; //弧尾相同的下一条弧
    char *info;              //该弧信息
} arcnode;
typedef struct vnode {
    char data;         //结点信息
    arcnode *firstarc; //指想第一条依附该结点的弧的指针
} vnode, adjlist;
// 邻接表表示的无向图 G，输出每一个连通分量的结点。
int visited[];
vnode g[];
arcnode *p; // 顶点的数组地址
void dfs(int v)
{
    visited[v] = 1;
    printf("%3d", v); //输出连通分量的顶点
    p = g[v].firstarc;
    while (p != NULL) {
        if (visited[p->adjvex] == 0) {
            dfs(p->adjvex);
        }
        p = p->nextarc;
    }
}
void count(adjlist g, int n) // 求图中连通分量的个数 设无向图g有n个结点
{
    int k = 0;
    for (int i = 1; i <= n; i++) {
        if (visited[i] == 0) {
            printf("\n第%d个连通分量:\n", ++k);
            dfs(i);
        }
    }
}

// 程序2
#include <stdio.h>
const int MAXN = 100;
typedef struct ArcCell {
    int vexnum[MAXN];       //顶点
    int arcnum[MAXN][MAXN]; //弧
    int n, e;               //顶点数， 弧数
} Graph;
int visit[MAXN] = {0}; // 用于存储判断顶点是否被访问的情况
// 对连通分量进行深度搜索
void DFSTraverse(Graph G, int i)
{
    // 要求输出每一个连通分量的结点
    printf("%3d", G.vexnum[i]); // 当前顶点
    for (int j = 0; j < G.n; j++) { // 遍历当前结点
        if (G.arcnum[i][j] && !visit[j]) { // 判断数据情况和被访问情况
            visit[j] = 1; // 标记访问情况
            DFSTraverse(G, j); // 对当前节点继续深入搜索
        }
    }
}
// 对整个图进行深度搜索
void DFS(Graph G)
{
    int k = 0;
    // 遍历邻接矩阵无向图
    for (int i = 0; i < G.n; i++) {
        if (!visit[i]) { // 顶点是否被访问
            visit[i] = 1; // 标记访问情况
            printf("\n第 %d 个连通分量:\n", k++);
            DFSTraverse(G, i); // 连通分量
        }
    }
}
// 主函数
int main()
{
    Graph G; // = xxxx; // 已知邻接表表示的无向图 G
    DFS(G);  // 编写求其的连通分量的算法
    return 0;
}