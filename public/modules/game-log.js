/**
 * GameLog Module
 * Handles game log display with bi-directional pagination and polling
 */

const GameLog = (function () {
  'use strict';

  let state = {
    newestLogId: null,
    oldestLogId: null,
    isLoadingNewer: false,
    isLoadingOlder: false,
    hasMore: false,
    pollInterval: null,
    API: null,
    State: null
  };

  function init({ State, API }) {
    state.API = API;
    state.State = State;

    // Load initial logs
    loadInitial();

    // Start polling every 5 seconds
    startPolling();
  }


  async function loadInitial() {
    if (!state.State.settings.serverUrl || !state.State.settings.heroCode) return;

    const container = document.getElementById('gameLogList');
    if (!container) return;

    container.innerHTML = '<div class="log-loading">Загрузка логов...</div>';

    try {
      const result = await state.API.get('/api/game/logs', {
        code: state.State.settings.heroCode,
        limit: 20
      });

      if (result.status === 'ok') {
        const logs = result.logs || [];

        if (logs.length === 0) {
          container.innerHTML = '<div class="log-empty">Логов пока нет</div>';
          return;
        }

        // Track IDs for pagination
        if (logs.length > 0) {
          state.newestLogId = logs[0].id;
          state.oldestLogId = logs[logs.length - 1].id;
        }

        state.hasMore = result.has_more;

        renderLogs(logs, 'replace');
        updateLoadMoreButton();
      }
    } catch (err) {
      console.error('Error loading logs:', err);
      container.innerHTML = '<div class="log-error">Ошибка загрузки логов</div>';
    }
  }

  async function loadNewer() {
    if (state.isLoadingNewer || !state.newestLogId) return;

    state.isLoadingNewer = true;

    try {
      const result = await state.API.get('/api/game/logs', {
        code: state.State.settings.heroCode,
        after_id: state.newestLogId,
        limit: 50
      });

      if (result.status === 'ok') {
        const logs = result.logs || [];

        if (logs.length > 0) {
          state.newestLogId = logs[0].id;
          renderLogs(logs, 'prepend');
        }
      }
    } catch (err) {
      console.error('Error loading newer logs:', err);
    } finally {
      state.isLoadingNewer = false;
    }
  }

  async function loadOlder() {
    if (state.isLoadingOlder || !state.hasMore) return;

    state.isLoadingOlder = true;

    const btn = document.getElementById('gameLogLoadMore');
    if (btn) {
      btn.disabled = true;
      btn.textContent = 'Загрузка...';
    }

    try {
      const result = await state.API.get('/api/game/logs', {
        code: state.State.settings.heroCode,
        before_id: state.oldestLogId,
        limit: 20
      });

      if (result.status === 'ok') {
        const logs = result.logs || [];

        if (logs.length > 0) {
          state.oldestLogId = logs[logs.length - 1].id;
          renderLogs(logs, 'append');
        }

        state.hasMore = result.has_more;
        updateLoadMoreButton();
      }
    } catch (err) {
      console.error('Error loading older logs:', err);
    } finally {
      state.isLoadingOlder = false;
      if (btn) {
        btn.disabled = false;
        btn.textContent = 'Загрузить еще';
      }
    }
  }

  function renderLogs(logs, mode = 'replace') {
    const container = document.getElementById('gameLogList');
    if (!container) return;

    if (mode === 'replace') {
      container.innerHTML = '';
    }

    logs.forEach(log => {
      const logEl = createLogElement(log);

      if (mode === 'prepend') {
        // Add to top with animation
        logEl.classList.add('log-new');
        container.insertBefore(logEl, container.firstChild);
        // Trigger animation
        setTimeout(() => logEl.classList.remove('log-new'), 100);
      } else {
        // Add to bottom
        container.appendChild(logEl);
      }
    });
  }

  function createLogElement(log) {
    const div = document.createElement('div');
    div.className = 'log-entry';
    div.dataset.logId = log.id;

    const time = formatTime(log.created_at);
    const content = formatLogContent(log);

    div.innerHTML = `
      <span class="log-time">${time}</span>
      <span class="log-hero">${escape(log.hero_name)}</span>
      <span class="log-content">${content}</span>
    `;

    return div;
  }

  function formatLogContent(log) {
    if (log.log_type === 'dice_roll') {
      const { dice, rolls, total } = log.data;
      const breakdown = rolls.length === 1 ? '' : `${rolls.join(' + ')} = `;
      return `🎲 ${dice}: ${breakdown}<strong>${total}</strong>`;
    }
    return 'Unknown log type';
  }

  function formatTime(isoString) {
    const date = new Date(isoString);
    return date.toLocaleTimeString('ru-RU', {
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    });
  }

  function escape(text) {
    if (!text) return '';
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
  }

  function updateLoadMoreButton() {
    const btn = document.getElementById('gameLogLoadMore');
    if (!btn) return;
    btn.style.display = state.hasMore ? 'block' : 'none';
  }

  function startPolling() {
    // Poll every 5 seconds
    state.pollInterval = setInterval(() => {
      loadNewer();
    }, 5000);
  }

  function stopPolling() {
    if (state.pollInterval) {
      clearInterval(state.pollInterval);
      state.pollInterval = null;
    }
  }

  return {
    init,
    loadOlder
  };
})();
