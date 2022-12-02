item = reaper.GetSelectedMediaItem(0, 0)
take = reaper.GetActiveTake(item)
r, _, cc_cnt, _ = reaper.MIDI_CountEvts(take)

is_any_deleted = true
while is_any_deleted == true do
  is_any_deleted = false
  for i = 0, cc_cnt do
    _, _, _, _, chanmsg, _, _, _ = reaper.MIDI_GetCC(take, i)
    if chanmsg == 224 or chanmsg == 0 then
    else
      reaper.MIDI_DeleteCC(take, i)
      is_any_deleted = true
    end
  end
end

