/**
 * Dice Module
 * Handles dice rolling with server sync and local fallback
 */

const Dice = (function () {
  'use strict';

  function rollLocal(dice) {
    const match = dice.match(/(\d*)d(\d+)/);
    const count = parseInt(match[1]) || 1;
    const sides = parseInt(match[2]);
    const rolls = [];

    for (let i = 0; i < count; i++) {
      rolls.push(Math.floor(Math.random() * sides) + 1);
    }

    return { rolls, total: rolls.reduce((a, b) => a + b, 0) };
  }

  function formatResult(dice, rolls, total) {
    if (rolls.length === 1) {
      return `${dice}: ${total}`;
    }
    return `${dice}: ${rolls.join(' + ')} = ${total}`;
  }

  async function execute(dice, { State, Config, API }) {
    const now = Date.now();
    if (now - State.lastRollTime < Config.COOLDOWN_MS) return;

    State.lastRollTime = now;
    startCooldown(State, Config);

    document.querySelectorAll('.dice-btn').forEach(btn => btn.disabled = true);

    const resultEl = document.getElementById('diceResult');
    resultEl.className = 'dice-result';
    resultEl.innerHTML = '<div class="result-value">...</div><div class="result-breakdown">' + dice + '</div>';

    let rolls = [];
    let total = 0;
    let isOffline = false;

    // Try server first
    const serverResult = await API.roll(dice);

    if (serverResult) {
      rolls = serverResult.rolls;
      total = serverResult.total;
    } else {
      // Local fallback
      const localResult = rollLocal(dice);
      rolls = localResult.rolls;
      total = localResult.total;
      isOffline = true;
    }

    // Display
    let className = '';
    if (dice === '2d6') {
      if (total >= 10) className = 'success';
      else if (total >= 7) className = 'partial';
      else className = 'fail';
    }

    const breakdown = formatResult(dice, rolls, total);

    resultEl.className = 'dice-result ' + className;
    resultEl.innerHTML = `
      <div class="result-value">${total}</div>
      <div class="result-breakdown">${breakdown}</div>
      ${isOffline ? '<div class="result-offline">(offline)</div>' : ''}
    `;

    addToLog(breakdown, isOffline);
  }

  function startCooldown(State, Config) {
    const fill = document.getElementById('cooldownFill');
    fill.style.width = '100%';

    let elapsed = 0;
    const step = 100;

    if (State.cooldownInterval) clearInterval(State.cooldownInterval);

    State.cooldownInterval = setInterval(() => {
      elapsed += step;
      fill.style.width = (100 - (elapsed / Config.COOLDOWN_MS * 100)) + '%';

      if (elapsed >= Config.COOLDOWN_MS) {
        clearInterval(State.cooldownInterval);
        fill.style.width = '0%';
        document.querySelectorAll('.dice-btn').forEach(btn => btn.disabled = false);
      }
    }, step);
  }

  function addToLog(text, isOffline) {
    const log = document.getElementById('diceLog');
    const time = new Date().toLocaleTimeString('ru-RU', { hour: '2-digit', minute: '2-digit', second: '2-digit' });

    const entry = document.createElement('div');
    entry.className = 'log-entry';
    entry.innerHTML = `<span class="log-time">${time}</span><span class="log-result">${text}${isOffline ? ' (offline)' : ''}</span>`;

    log.insertBefore(entry, log.firstChild);
    log.scrollTop = 0;

    while (log.children.length > 5) {
      log.removeChild(log.lastChild);
    }
  }

  return {
    execute
  };
})();
