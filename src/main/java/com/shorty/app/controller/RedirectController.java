package com.shorty.app.controller;

import com.shorty.app.entity.Redirect;
import com.shorty.app.request.RedirectCreationRequest;
import com.shorty.app.service.RedirectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.net.URI;
import java.net.URISyntaxException;

@RestController
public class RedirectController {

    private RedirectService redirectService;

    @Autowired
    private RedirectController(RedirectService redirectService){
        this.redirectService = redirectService;
    }

    @GetMapping("/{alias}")
    public ResponseEntity<?> handleRedirect(@PathVariable String alias){
        Redirect redirect = redirectService.getRedirect(alias);
        URI uri = null;
        try {
            uri = new URI(redirect.getUrl());
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setLocation(uri);
        return new ResponseEntity<>(httpHeaders, HttpStatus.MOVED_PERMANENTLY);
    }

    @PostMapping("/")
    public ResponseEntity<?> createRedirect(@Valid @RequestBody RedirectCreationRequest redirectCreationRequest){
        return ResponseEntity.ok(redirectService.createRedirect(redirectCreationRequest));
    }
}
