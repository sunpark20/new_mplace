package hungry.ex_frag.day;

import android.content.Intent;
import android.graphics.drawable.AnimationDrawable;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

import java.util.ArrayList;

import hungry.ex_frag.ActivityHelper;
import hungry.ex_frag.R;
import hungry.ex_frag.VideoPlayerActivity;

public class Day_Activity extends ActivityHelper {
    private static final String TAG = Day_Activity.class.getSimpleName();

    private ArrayList<TI> tiArray;
    private int currentPage = 0;

    private TextView tv;
    private TextView pageNum;
    private TextView timerTv;
    private ImageView iv;
    private Button youtubeButton;
    private FrameLayout fl;
    private ScrollView scV;

    private MediaPlayer fsMedia;
    private AnimationDrawable frameAnimation;
    private android.os.CountDownTimer countDownTimer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d(TAG, "onCreate");
        setContentView(R.layout.frag_day);

        Intent intent = getIntent();
        String title = intent.getStringExtra("title");
        tiArray = (ArrayList<TI>) intent.getSerializableExtra("tiArray");
        setTitle(title);

        AdView mAdView = findViewById(R.id.adView111);
        mAdView.loadAd(new AdRequest.Builder().build());

        tv = findViewById(R.id.tvFragDay1_1);
        pageNum = findViewById(R.id.pageNum);
        timerTv = findViewById(R.id.timer);
        iv = findViewById(R.id.image);
        Button preButton = findViewById(R.id.previousButton);
        Button nextButton = findViewById(R.id.nextButton);
        fl = findViewById(R.id.fl);

        iv.setOnTouchListener(new OnSwipeTouchListener(getApplicationContext()) {
            @Override
            public void onSwipeRight() {
                preLoad();
            }

            @Override
            public void onSwipeLeft() {
                nextLoad();
            }

            @Override
            public void onTouch() {
                handleTouchAction();
            }
        });

        scV = findViewById(R.id.scV);
        scV.setOnTouchListener(new OnSwipeTouchListener(getApplicationContext()) {
            @Override
            public void onSwipeRight() {
                preLoad();
            }

            @Override
            public void onSwipeLeft() {
                nextLoad();
            }
        });

        youtubeButton = findViewById(R.id.youtubeButton);
        youtubeButton.setOnClickListener(v -> {
            try {
                java.io.File file = new java.io.File(getCacheDir(), "ted_video.mp4");
                if (!file.exists()) {
                    java.io.InputStream in = getResources().openRawResource(R.raw.ted_video);
                    java.io.OutputStream out = new java.io.FileOutputStream(file);
                    byte[] buffer = new byte[1024];
                    int read;
                    while ((read = in.read(buffer)) != -1) {
                        out.write(buffer, 0, read);
                    }
                    in.close();
                    out.flush();
                    out.close();
                }

                Uri videoUri = androidx.core.content.FileProvider.getUriForFile(this, getPackageName() + ".fileprovider", file);
                Intent videoIntent = new Intent(Intent.ACTION_VIEW);
                videoIntent.setDataAndType(videoUri, "video/*");
                videoIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                startActivity(Intent.createChooser(videoIntent, "동영상 재생"));
            } catch (Exception e) {
                e.printStackTrace();
                Toast.makeText(this, "동영상을 재생할 수 없습니다.", Toast.LENGTH_SHORT).show();
            }
        });

        preButton.setOnClickListener(v -> preLoad());
        nextButton.setOnClickListener(v -> nextLoad());

        updatePageContent();
    }

    private void preLoad() {
        if (currentPage > 0) {
            currentPage--;
            updatePageContent();
        } else {
            Toast.makeText(getApplicationContext(), "처음", Toast.LENGTH_SHORT).show();
        }
    }

    private void nextLoad() {
        if (currentPage < tiArray.size() - 1) {
            currentPage++;
            updatePageContent();
        } else {
            Toast.makeText(getApplicationContext(), "끝", Toast.LENGTH_SHORT).show();
            finish(); // 첫 화면으로 돌아가기 위해 현재 액티비티 종료
        }
    }

    private void updatePageContent() {
        if (tiArray == null || tiArray.isEmpty()) return;

        TI currentTI = tiArray.get(currentPage);

        // 텍스트 설정 및 스크롤 즉시 리셋
        if (currentTI.isHtml) {
            tv.setText(android.text.Html.fromHtml(currentTI.text));
            tv.setMovementMethod(android.text.method.LinkMovementMethod.getInstance());
        } else {
            tv.setText(currentTI.text);
            tv.setMovementMethod(null);
        }

        // 스크롤 위치 초기화 (즉시 리셋 및 포커스 해제)
        tv.clearFocus();
        scV.setScrollY(0);
        scV.scrollTo(0, 0);
        
        // 레이아웃이 완전히 그려진 후 다시 한번 리셋 (강력한 조치)
        scV.post(() -> {
            scV.scrollTo(0, 0);
            scV.fullScroll(View.FOCUS_UP);
        });
        scV.postDelayed(() -> scV.scrollTo(0, 0), 50);
        scV.postDelayed(() -> scV.scrollTo(0, 0), 200);

        pageNum.setText((currentPage + 1) + " / " + tiArray.size());

        stopSound();
        stopAnimation();
        stopTimer();

        // 이미지 및 애니메이션 영역 가시성 처리
        if (currentTI.isYoutubeLink) {
            fl.setVisibility(View.GONE);
            youtubeButton.setVisibility(View.VISIBLE);
        } else {
            youtubeButton.setVisibility(View.GONE);
            if (currentTI.imageResId != 0 || currentTI.animationDrawableResId != 0) {
                fl.setVisibility(View.VISIBLE);
                iv.setVisibility(View.VISIBLE);
                if (currentTI.imageResId != 0) {
                    iv.setImageResource(currentTI.imageResId);
                } else {
                    iv.setImageDrawable(null);
                }
            } else {
                iv.setVisibility(View.GONE);
                fl.setVisibility(View.GONE);
            }
        }

        // 애니메이션이 있고 타이머가 있다면 타이머 종료 후 실행, 아니면 즉시 실행
        if (currentTI.animationDrawableResId != 0) {
            if (currentTI.alarmTimeInSeconds <= 0 || currentTI.imageResId == 0) {
                // 이미지Resource가 0이면 처음부터 애니메이션 실행 (10페이지 스타일)
                setAnimation(currentTI.animationDrawableResId);
            }
        }

        if (currentTI.soundResId != 0) {
            runSound(currentTI.soundResId);
        }

        if (currentTI.alarmTimeInSeconds > 0) {
            startTimer(currentTI.alarmTimeInSeconds, currentTI.animationDrawableResId, currentTI.resultImageResId);
        }
    }

    private void startTimer(int seconds, int animResId, int resultImgId) {
        timerTv.setVisibility(View.VISIBLE);
        countDownTimer = new android.os.CountDownTimer(seconds * 1000, 1000) {
            @Override
            public void onTick(long millisUntilFinished) {
                int sec = (int) (millisUntilFinished / 1000);
                int min = sec / 60;
                sec = sec % 60;
                timerTv.setText(String.format("%02d:%02d", min, sec));
            }

            @Override
            public void onFinish() {
                timerTv.setText("00:00");
                runSound(R.raw.alarm);
                
                // 타이머 종료 후 연출
                if (resultImgId != 0) {
                    // 결과 이미지가 지정되어 있으면 이미지 교체 (애니메이션 중지)
                    stopAnimation();
                    iv.setImageResource(resultImgId);
                    iv.setVisibility(View.VISIBLE);
                } else if (animResId != 0) {
                    // 결과 이미지가 없고 애니메이션만 있으면 애니메이션 실행 (기존 스타일)
                    setAnimation(animResId);
                }
                
                android.widget.Toast.makeText(Day_Activity.this, "시간이 다 되었습니다!", android.widget.Toast.LENGTH_SHORT).show();
            }
        }.start();
    }

    private void stopTimer() {
        if (countDownTimer != null) {
            countDownTimer.cancel();
            countDownTimer = null;
        }
        timerTv.setVisibility(View.GONE);
    }

    private void handleTouchAction() {
        TI currentTI = tiArray.get(currentPage);
        if (currentTI.hasTouchSound) {
            runSound(R.raw.highfive);
        }
        if (currentTI.isTouchPage) {
            nextLoad();
        }
    }

    private void setAnimation(int animResId) {
        iv.setImageDrawable(null); // Clear previous image
        iv.setImageResource(animResId); // Set animation as image source
        Object drawable = iv.getDrawable();
        if (drawable instanceof AnimationDrawable) {
            frameAnimation = (AnimationDrawable) drawable;
            frameAnimation.start();
        }
    }

    private void stopAnimation() {
        if (frameAnimation != null && frameAnimation.isRunning()) {
            frameAnimation.stop();
        }
        frameAnimation = null;
    }

    private void runSound(int soundResId) {
        stopSound();
        fsMedia = MediaPlayer.create(this, soundResId);
        if (fsMedia != null) {
            fsMedia.setOnCompletionListener(mp -> {
                mp.release();
                fsMedia = null;
            });
            fsMedia.start();
        }
    }

    private void stopSound() {
        if (fsMedia != null) {
            fsMedia.release();
            fsMedia = null;
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopSound();
        stopAnimation();
        stopTimer();
    }
}
