Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416C9132693
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2020 13:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgAGMkK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Jan 2020 07:40:10 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39934 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgAGMkK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 07:40:10 -0500
Received: by mail-il1-f194.google.com with SMTP id x5so45569945ila.6
        for <linux-block@vger.kernel.org>; Tue, 07 Jan 2020 04:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGGRxiRBeuUoiWYAF0rXXnn8VinREOmG6AvgFZVfjF0=;
        b=EWco4wtCM0tg/Uv33tzijxSlrHPELApc8ks6NI8bck5WaG9wwGjVuTiaBtrgGrGqW8
         Hwn5uxe6n+ZYfcCuB1oFmKZu4Y1FZilYebe4338pBzbupAwwJEFAwnnblMz9TG1EMUlo
         OWT6dfvN2BQnQ7uMIWiZUuk3Rbyu+uOQgU7pCxK2oaAetKJgKoNOdWhdfRa+OEnVaXUa
         Ktplks4DNSlz10DKmz5ID+lc33Lsd7Jt3+EngEU8x+SlpjZrJRoP7ag4DghuSQTwh4B0
         xQt/8QGJdKsI5ql8SEjIiFY1TTAh85eQihjgX0gGN7j8fX83xuPHgZBY09L2upQORYI3
         DkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGGRxiRBeuUoiWYAF0rXXnn8VinREOmG6AvgFZVfjF0=;
        b=NgWuoVV5WH3rVgKwaVNwVxbhdgdLRQYzAGzMKvOpHPCkW4oZBiZG7CmIkOibBRfer4
         JEteiYe423LVu2hQuHlTIEKTFZksZuWsiasTe/xK0esdRxaUCdPNhl4Nr+zoiJy0GMJy
         vW9YQG37oRiztfMUSAXVRyBwSy+i6B0gMPtLRyrAFW1mjyRkd0wQgZTBy6X2J/QH47+g
         vy8NK2A8gt/JG1JedTckG19ggyaru6LlJTqeC/sF5Nm8wygp/3fm9Gx380kNTSeMW9RN
         SkHdhc7h/w4of6NZJRqUqXhKQFvKTgvlPCm0VquAzZT09Yuk5HeJBjXdLBIZeY+Kapuj
         D2CA==
X-Gm-Message-State: APjAAAUmPGr8a0xmjlW4pLMGKZWWlgwlEcZT1cYD0SNTpwpH/TqEU9B9
        y+y0STThstlrOJWk9A9zDozYcKXt9tFKAlaLnDWtug==
X-Google-Smtp-Source: APXvYqxWS25mAwzf+btFu9iMsX75112qkScfAdWSlCRJEpUdX9St839L2ZpwR7Ow6LDs3v3CORrtkhFTvwUSlybefrc=
X-Received: by 2002:a92:1090:: with SMTP id 16mr87451291ilq.298.1578400809537;
 Tue, 07 Jan 2020 04:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-6-jinpuwang@gmail.com>
 <db1bc453-7ea5-978a-7418-af05c7c8cba7@acm.org>
In-Reply-To: <db1bc453-7ea5-978a-7418-af05c7c8cba7@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 13:39:58 +0100
Message-ID: <CAMGffEmNuVVJCFBdszevXRdLeFB9RYP5cYWuX6-psRXESV4QtQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/25] rtrs: client: private header with client structs
 and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 31, 2019 at 12:03 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2019-12-30 02:29, Jack Wang wrote:
> > +#define GET_PERMIT(clt, idx) ((clt)->permits + PERMIT_SIZE(clt) * idx)
>
> Please surround 'idx' with parentheses.
>
> Thanks,
>
> Bart.
will do, thanks
