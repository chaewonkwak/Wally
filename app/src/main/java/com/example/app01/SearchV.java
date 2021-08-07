package com.example.app01;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.SearchView;
import android.widget.TextView;

import java.util.Arrays;
import java.util.List;

public class SearchV extends AppCompatActivity {
    private List<String> items = Arrays.asList("생리대1", "생리대2", "생리대3", "생선", "배구" );
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        SearchView searchView = findViewById(R.id.search_view);
        TextView resultTextView = findViewById(R.id.textView);
        //resultTextView.setText(getResult());

        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                return false;
            }

            @Override
            public boolean onQueryTextChange(String newText) {
                resultTextView.setText(search(newText));
                return true;
            }
        });
    }
    private String search(String query){
        StringBuilder sb = new StringBuilder();
        for(int i = 0; i < items.size(); i++) {
            String item = items.get(i);
            if(item.toLowerCase().contains(query.toLowerCase())){
                sb.append(item);
                if(i != items.size() - 1) {
                    sb.append("\n");
                }
            }
        }
        return sb.toString();
    }
    private String getResult(){
        StringBuilder sb = new StringBuilder();
        for(int i = 0; i < items.size(); i++) {
            String item = items.get(i);
            sb.append(item);
            if(i != items.size() - 1) {
                sb.append("\n");
            }
        }
        return sb.toString();
    }
}
