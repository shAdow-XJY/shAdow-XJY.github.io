class VideoData {
  static Map<String, Map<String, String>> videoData = {
    "夏日预告企划": {
      "bilibili": '''
      <iframe 
        src="//player.bilibili.com/player.html?isOutside=true&aid=938701785&bvid=BV1gT4y1k7dz&cid=711347686&p=1" 
        style="width:100%; aspect-ratio:16/9; border:none;" 
        frameborder="0" 
        scrolling="no" 
        allowfullscreen="true">
      </iframe>
      ''',
      "youtube": '''
      <iframe 
        src="https://www.youtube.com/embed/ZI-GnWGzAMo?si=NeJcJzjkGjgHXJiN" 
        style="width:100%; aspect-ratio:16/9; border:none;" 
        frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
        referrerpolicy="strict-origin-when-cross-origin" 
        allowfullscreen>
      </iframe>
      ''',
    }
  };
}