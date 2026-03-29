/**
 * AmbientMusic Module
 * Handles YouTube ambient music player with volume control
 */

const AmbientMusic = (function () {
  'use strict';

  let state = {
    player: null,
    isPlaying: false,
    volume: 15,
    videoId: null,
    isPlaylist: false,
    API: null,
    State: null
  };

  const STORAGE_KEY = 'dw_ambient_volume';

  function init({ State, API }) {
    state.API = API;
    state.State = State;

    // Load saved volume
    const savedVolume = localStorage.getItem(STORAGE_KEY);
    if (savedVolume) {
      state.volume = parseInt(savedVolume);
    }

    // Load YouTube API
    loadYouTubeAPI();

    // Fetch game settings
    loadGameSettings();
  }

  function loadYouTubeAPI() {
    if (window.YT) {
      onYouTubeAPIReady();
      return;
    }

    // Load YouTube iframe API
    const tag = document.createElement('script');
    tag.src = 'https://www.youtube.com/iframe_api';
    const firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    window.onYouTubeIframeAPIReady = onYouTubeAPIReady;
  }

  function onYouTubeAPIReady() {
    // API is ready, wait for game settings
    if (state.videoId) {
      createPlayer();
    }
  }

  async function loadGameSettings() {
    if (!state.State.settings.serverUrl || !state.State.settings.heroCode) return;

    try {
      const result = await state.API.get('/api/game/current', {
        code: state.State.settings.heroCode
      });

      if (result.status === 'ok' && result.game && result.game.ambient_music_url) {
        const url = result.game.ambient_music_url;
        const videoInfo = parseYouTubeURL(url);

        if (videoInfo) {
          state.videoId = videoInfo.id;
          state.isPlaylist = videoInfo.isPlaylist;

          if (window.YT && window.YT.Player) {
            createPlayer();
          }
        }
      }
    } catch (err) {
      console.error('Error loading game settings:', err);
    }
  }

  function parseYouTubeURL(url) {
    // Playlist: https://youtube.com/playlist?list=PLxxx or https://www.youtube.com/watch?v=xxx&list=PLxxx
    // Video: https://youtube.com/watch?v=xxx or https://youtu.be/xxx

    const playlistMatch = url.match(/[?&]list=([^&]+)/);
    if (playlistMatch) {
      return { id: playlistMatch[1], isPlaylist: true };
    }

    const videoMatch = url.match(/(?:youtube\.com\/watch\?v=|youtu\.be\/)([^&?]+)/);
    if (videoMatch) {
      return { id: videoMatch[1], isPlaylist: false };
    }

    return null;
  }

  function createPlayer() {
    const container = document.getElementById('ambientMusicContainer');
    const controls = document.getElementById('ambientMusicControls');

    if (!container || !controls) return;

    // Hide empty message, show controls
    container.innerHTML = '';
    controls.style.display = 'block';

    // Update volume slider
    const volumeSlider = document.getElementById('ambientVolumeSlider');
    const volumeValue = document.getElementById('ambientVolumeValue');
    if (volumeSlider && volumeValue) {
      volumeSlider.value = state.volume;
      volumeValue.textContent = `${state.volume}%`;
    }

    // Create player
    state.player = new YT.Player('ambientPlayer', {
      height: '0',
      width: '0',
      videoId: state.isPlaylist ? null : state.videoId,
      playerVars: {
        autoplay: 0,
        loop: 1,
        playlist: state.isPlaylist ? state.videoId : state.videoId,
        controls: 0,
        modestbranding: 1,
        rel: 0
      },
      events: {
        onReady: onPlayerReady,
        onStateChange: onPlayerStateChange,
        onError: onPlayerError
      }
    });

    setupControls();
  }

  function onPlayerReady(event) {
    state.player.setVolume(state.volume);

    // Try to play with error handling
    const playPromise = state.player.playVideo();

    if (playPromise !== undefined) {
      setTimeout(() => {
        const playerState = state.player.getPlayerState();
        if (playerState === YT.PlayerState.PLAYING) {
          state.isPlaying = true;
        } else {
          state.isPlaying = false;
        }
        updatePlayPauseButton();
      }, 500);
    } else {
      state.isPlaying = true;
      updatePlayPauseButton();
    }
  }

  function onPlayerError(event) {
    console.error('YouTube player error:', event.data);
    state.isPlaying = false;
    updatePlayPauseButton();
  }

  function onPlayerStateChange(event) {
    // Update state based on player state
    if (event.data === YT.PlayerState.PLAYING) {
      state.isPlaying = true;
      updatePlayPauseButton();
    } else if (event.data === YT.PlayerState.PAUSED || event.data === YT.PlayerState.ENDED) {
      state.isPlaying = false;
      updatePlayPauseButton();
    }
  }

  function setupControls() {
    const playPauseBtn = document.getElementById('ambientPlayPause');
    const volumeSlider = document.getElementById('ambientVolumeSlider');
    const volumeValue = document.getElementById('ambientVolumeValue');

    if (playPauseBtn) {
      playPauseBtn.addEventListener('click', togglePlayPause);
    }

    if (volumeSlider) {
      volumeSlider.addEventListener('input', (e) => {
        const volume = parseInt(e.target.value);
        state.volume = volume;
        volumeValue.textContent = `${volume}%`;

        if (state.player) {
          state.player.setVolume(volume);
        }

        localStorage.setItem(STORAGE_KEY, volume);
      });
    }
  }

  function togglePlayPause() {
    if (!state.player) return;

    if (state.isPlaying) {
      state.player.pauseVideo();
      state.isPlaying = false;
    } else {
      state.player.playVideo();
      state.isPlaying = true;
    }

    updatePlayPauseButton();
  }

  function updatePlayPauseButton() {
    const btn = document.getElementById('ambientPlayPause');
    if (!btn) return;

    btn.textContent = state.isPlaying ? '⏸ Pause' : '▶ Play';
  }

  return {
    init
  };
})();
