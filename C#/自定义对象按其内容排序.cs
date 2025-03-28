using System;

public static class 自定义对象按其内容排序
{
    /// <summary>
    /// 根据 `ReplaceJob` 的 `PathLevel` 降序排序。
    /// </summary>
    /// <param name="jobs">待排序的 `ReplaceJob` 数组</param>
    /// <returns>按照 `PathLevel` 降序排序的新数组，如果输入为空则返回空数组。</returns>
    public static ReplaceJob[] SortJobsByLevel(ReplaceJob[] jobs)
    {
        // 如果 jobs 为空，返回空数组（兼容 .NET 4.5 及以下）
        if (jobs == null || jobs.Length == 0)
        {
#if NET46_OR_GREATER
            return Array.Empty<ReplaceJob>(); // .NET 4.6+ 直接使用 Array.Empty
#else
            return new ReplaceJob[0]; // .NET 4.5 及更早版本
#endif
        }

        // 复制数组，避免修改原始数据
        ReplaceJob[] sortedJobs = (ReplaceJob[])jobs.Clone();

        // 按 PathLevel 进行降序排序
        Array.Sort(sortedJobs, (job1, job2) => job2.PathLevel.CompareTo(job1.PathLevel));

        return sortedJobs;
    }
}
