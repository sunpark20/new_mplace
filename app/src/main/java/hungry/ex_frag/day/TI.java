package hungry.ex_frag.day;

import java.io.Serializable;

public class TI implements Serializable {
    public String text;
    public int imageResId;

    // Optional properties for special behaviors
    public int animationDrawableResId = 0;
    public int soundResId = 0;
    public boolean hasTouchSound = false;
    public boolean isYoutubeLink = false;
    public int alarmTimeInSeconds = 0;
    public boolean isHtml = false;
    public boolean isTouchPage = false;
    public int resultImageResId = 0;

    public TI(String text, int imageResId) {
        this.text = text;
        this.imageResId = imageResId;
    }

    public TI withAnimation(int resId) {
        this.animationDrawableResId = resId;
        return this;
    }

    public TI withSound(int resId) {
        this.soundResId = resId;
        return this;
    }

    public TI withTouchSound() {
        this.hasTouchSound = true;
        return this;
    }

    public TI asYoutubeLink() {
        this.isYoutubeLink = true;
        return this;
    }

    public TI withAlarm(int seconds) {
        this.alarmTimeInSeconds = seconds;
        return this;
    }

    public TI asHtml() {
        this.isHtml = true;
        return this;
    }

    public TI asTouchPage() {
        this.isTouchPage = true;
        return this;
    }

    public TI withResultImage(int resId) {
        this.resultImageResId = resId;
        return this;
    }
}